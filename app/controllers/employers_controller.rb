class EmployersController < ApplicationController
  def new

  end

  def index
  end



  def create
  	employer = Employer.authenticate_employer(params[:login], params[:password])
  	if employer
  		session[:employer_id] = employer.id
  		redirect_to url_for(controller: 'employers_registering', action: 'employerlogged')
  	else
  		flash.now.alert = "Niepoprawne hasło/login"
  	    render "new"
  	end
  end

  	def destroy
	  session[:employer_id] = nil
	  redirect_to root_url, :notice => "Poprawnie wylogowano!"
	end


end