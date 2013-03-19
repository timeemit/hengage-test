class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :authenticate_user!

  def require_admin!
    redirect_to :root unless current_user.admin?
  end
  
end
