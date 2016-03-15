class UsersController < ApplicationController
	before_action :logged_in_user, only: [:edit, :update, :show]
	before_action :correct_user,   only: [:edit, :update]

	def welcome
	end

      def show
	    @user = User.find(params[:id])
	  end

	def new
  # 	  if logged_in?
		# redirect_to url_for(controller: 'test_tasks', action: 'main')
	 #  end
	  @user = User.new
	end

	  def edit
	    @user = User.find(params[:id])
	  end

	  def update
	    @user = User.find(params[:id])
	    if @user.update_attributes(user_params)
	        flash[:success] = "Profile updated"
      		redirect_to url_for(controller: 'test_tasks', action: 'main')
	    else
	    	flash[:success] = "Profile not updated"
	      render 'edit'
	    end
	  end

	# def index
	# 	@users = User.all
	# end

	def destroy
		User.find(params[:id]).destroy
    	flash[:success] = "User deleted"
  		redirect_to url_for(controller: 'app_manager', action: 'index')
  	end

	def create
	  @user = User.new(params[:user])
	  if @user.save
	    redirect_to url_for(controller: 'test_tasks', action: 'signed'), :notice => "Poprawnie zarejestrowano!"
	  else
	    render "new"
	  end
	end

	def logged_in_user
	  unless logged_in?
	    flash[:danger] = "Proszę się zalogować."
	    redirect_to url_for(controller: 'sessions', action: 'new')
	  end
	end

	private

	    def user_params
	      params.require(:user).permit(:email, :password,
	                                   :password_confirmation)
	    end

        # Confirms the correct user.
	    def correct_user
	      @user = User.find(params[:id])
	      redirect_to url_for(controller: 'test_tasks', action: 'main') unless @user == current_user 
	    end
end
