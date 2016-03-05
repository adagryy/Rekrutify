class AppManagerController < ApplicationController
	before_action :logged_in_employer
	

  def show
  end

  def index
  	@users = User.all
  end

  def destroy
  	# flash.now.alert = "Niepoprawne hasło/login"
  end

	# Confirms a logged-in user.
	def logged_in_employer
	  unless logged_employer_in?
	    flash[:danger] = "Proszę się zalogować."
	    redirect_to url_for(controller: 'employers', action: 'create')
	  end
	end
end
