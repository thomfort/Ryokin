class ApplicationController < ActionController::Base
  protect_from_forgery
  
  
  def rating_advisor
    @advisor = Advisor.find(params[:id])
    @advisor.rate_it( params[:rate], current_user )
    
    redirect_to advisors_url 
  end
  

  
  private
  
  def not_authenticated
    redirect_to login_url, :alert => "First login to acces this page"
  end
end
