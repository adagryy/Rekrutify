class EmployersController < ApplicationController
  # before_action :startt

  def new

  end

  def index
  end

  def create
  	employer = Employer.authenticate_employer(params[:login], params[:password])
  	if employer
  		session[:employer_id] = employer.id
  		redirect_to url_for(controller: 'app_manager', action: 'index')
  	else
  		# if @flag == false
  		# 	flash.now.alert = "Niepoprawne hasło/login"
  		# else
  		# 	set_flag(false)
  		# end
  	    render "new"
  	end
  end

  	def destroy
  	  # set_flag(true)
  	  session[:employer_id] = nil
	  redirect_to url_for(controller: 'employers', action: 'create'), :notice => "Poprawnie wylogowano Cię z konta administratora!"
	  
	end


		# def set_flag(value)
		# 	@flag = value
		# end
		# def startt
		# 	set_flag(false)
		# end
		# def reset_flag
		# 	@flag = false
		# end


end