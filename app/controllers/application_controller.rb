class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
   helper_method :current_user, :user_signed_in? , :profile_path

  def current_user
    # Ensure this logic correctly fetches your user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    # This method relies on the current_user method
    !!current_user
  end

    def profile_path
    if current_user
      if current_user.role == 'teacher'
        teacher_account_path
      elsif current_user.role == 'student'
        student_account_path
      else
        # Fallback if role is not set
        root_path
      end
    else
      # Should not be called if not logged in, but as a safeguard
      root_path
    end
  end

end
