module EmployersHelper
  def current_employer
    @current_employer ||= Employer.find_by(id: session[:employer_id]) 
  end

  def logged_employer_in?
    !current_employer.nil?
  end
end
