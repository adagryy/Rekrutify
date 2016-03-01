class UsersController < ApplicationController
	def welcome
	end

	def new
	  @user = User.new
	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to url_for(controller: 'test_tasks', action: 'signed'), :notice => "Signed up!"
	  else
	    render "new"
	  end
	end
end
