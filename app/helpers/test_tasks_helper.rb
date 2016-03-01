module TestTasksHelper
	   # Returns true if the user is logged in, false otherwise.
   def logged_in?
       !current_user.nil?
   end

   # Confirms a logged-in user.
   def logged_in_user
      unless logged_in?
         flash[:danger] = "Please log in."
         redirect_to url_for(controller: 'sessions_controller', action: 'new')
      end
   end
end
