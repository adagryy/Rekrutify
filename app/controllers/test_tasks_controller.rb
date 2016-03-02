class TestTasksController < ApplicationController
	before_action :logged_in_user

	def main
	end

	def signed
	end

  # Confirms a logged-in user.
	def logged_in_user
	  unless logged_in?
	    flash[:danger] = "Proszę się zalogować."
	    redirect_to url_for(controller: 'sessions', action: 'new')
	  end
	end
end
