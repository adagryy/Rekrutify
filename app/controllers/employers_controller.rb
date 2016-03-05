class EmployersController < ApplicationController

  def new
    if logged_employer_in?
      redirect_to url_for(controller: 'app_manager', action: 'index')
    end
  end

  def index
  end

  def create
  	employer = Employer.authenticate_employer(params[:login], params[:password])
  	# flash.now.alert = $not
  	if employer
  		session[:employer_id] = employer.id
  		redirect_to url_for(controller: 'app_manager', action: 'index')
  	else
  		if $not == true
  			flash.now.alert = ""
  			startt(false)
  		else
  			flash.now.alert = "Niepoprawne hasło/login"
  		end
  	    render "new"
  	end
  end

  	def destroy
  	   startt(true)
  	  session[:employer_id] = nil
	  redirect_to url_for(controller: 'employers', action: 'create'), :notice => "Poprawnie wylogowano Cię z konta administratora!"
	  
	end
	def startt(value)
		$not = value
	end
end