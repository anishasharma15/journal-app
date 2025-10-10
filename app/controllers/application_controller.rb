class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
   helper_method :current_user, :user_signed_in? 

  def current_user
    # Ensure this logic correctly fetches your user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    # This method relies on the current_user method
    !!current_user
  end
end
