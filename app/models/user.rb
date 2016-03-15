class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :mail
  
  attr_accessor :password
  before_save :encrypt_password
  
  VALID_MAIL_REGEX = /\A[\w+\-.]+@[a-z\-.]+\.[a-z]+\z/i
  validates_confirmation_of :password
  # validates_presence_of :password, :on => :create
  # validates_presence_of :email
  validates_uniqueness_of :email, message: 'W bazie istnieje już użytkownik z podanym loginem'

  validates :mail, presence: true, length: { maximum: 255 },
                    format: { with: VALID_MAIL_REGEX, :message => "Niepoprawny e-mail. Przykład poprawnego: foo@bar.com" },
                    uniqueness: { case_sensitive: false, message: 'W bazie istnieje już użytkownik z podanym adresem email' }
  validates :password, presence: { in: [true], message: 'Hasło musi mieć minimum 6 znaków'}, length: { minimum: 6 }, allow_nil: true

  def deliver_password_reset_instructions
    self.perishable_token = get_reset_token
    save(validate: false)

    PasswordResetNotifier.password_reset_instructions(self).deliver_now
  end

  def get_reset_token
    SecureRandom.urlsafe_base64
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  # Returns true if the given token matches the digest.
  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end
