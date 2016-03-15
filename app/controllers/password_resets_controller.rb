class PasswordResetsController < ApplicationController
	def new
	end

  def create
    user = User.where(mail: params[:mail]).first

    if user
      user.deliver_password_reset_instructions
      flash[:notice] = "E-mail z instrukcjami do zresetowania hasła został pomyślnie wysłany"
      redirect_to url_for(controller: 'sessions', action: 'new')
    else
      flash.now[:error] = "Nie znaleziono użytkownika z adresem E-mail: #{params[:mail]}"
      render :new
    end
  end

  def edit
    load_user_using_perishable_token
    @token = @user.perishable_token
  end

  def update
    load_user_using_perishable_token
    @user.password = params[:password]

    if @user.save and params[:password] == params[:password_confirmation]
      flash[:success] = "Your password was successfully updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user_using_perishable_token
    @user = User.where(perishable_token: params[:token]).first
    unless @user
      flash[:error] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end
end
