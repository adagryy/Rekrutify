class SessionsController < ApplicationController
	def new
		if logged_in?
			redirect_to url_for(controller: 'test_tasks', action: 'main') #redirects from login page if user is already logged in
		end
	end

	def create
	  user = User.authenticate(params[:email], params[:password])
	  if user
	    session[:user_id] = user.id
	    redirect_to url_for(controller: 'test_tasks', action: 'main'), :notice => "Poprawnie zalogowano!"
	  else
	    flash.now.alert = "Niepoprawne hasło/login"
	    render "new"
	  end
	end

	def destroy
	  session[:user_id] = nil
	  redirect_to root_url, :notice => "Poprawnie wylogowano!"
	end
end

#login, hasło, nazwa_firmy, telefon, adres

#miasto - do tabeli users 
#rails g model user email:string password_hash:string password_salt:string