class UsersController < ApplicationController
	def welcome
	end

	def new
  	  if logged_in?
		redirect_to url_for(controller: 'test_tasks', action: 'main')
	  end
	  @user = User.new
	end

	# def index
	# 	@users = User.all
	# end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to url_for(controller: 'test_tasks', action: 'signed'), :notice => "Poprawnie zarejestrowano!"
	  else
	    render "new"
	  end
	end
end
