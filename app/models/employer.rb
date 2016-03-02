class Employer < ActiveRecord::Base
	attr_accessible :login, :password, :password_confirmation, :company_name, :telephone, :address

	attr_accessor :password
    before_save :encrypt_employer_password

	validates_confirmation_of :password
    validates_presence_of :password, :on => :create
    validates_presence_of :login, :company_name, :telephone, :address
    validates_uniqueness_of :login

    def self.authenticate_employer(login, password)
	  employer = find_by_login(login)
	  if employer && employer.password_hash == BCrypt::Engine.hash_secret(password, employer.password_salt)
	    employer
	  else
	    nil
	  end
	end

    def encrypt_employer_password
      if password.present?
        self.password_salt = BCrypt::Engine.generate_salt
        self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
      end
    end
end
# Employer.create :login => "adagryy", :password => "abcd", :company_name => "PW", :telephone => "23432432", :address => "Warszawa"
