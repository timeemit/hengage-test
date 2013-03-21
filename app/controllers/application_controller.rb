class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!

  private 
  
  def require_admin!
    redirect_to :root, :alert => 'Stop!  You must be an admin to do that!' unless current_user.admin?
  end
  
  def time_from_params(time_string)
    Time.local(
      params[:report][time_string + '(1i)'], 
      params[:report][time_string + '(2i)'],
      params[:report][time_string + '(3i)'],
      params[:report][time_string + '(4i)'],
      params[:report][time_string + '(5i)'])
  end
  
end
