class EmployersRegisteringController < ApplicationController
	def new
	  @employer = Employer.new
	end

	def create
	  @employer = Employer.new(params[:employer])
	  if @employer.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

	 def employerlogged
  	flash.now.alert = "sdf"
  	
  end
end
