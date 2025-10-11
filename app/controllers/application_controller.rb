class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
   helper_method :current_user, :user_signed_in? , :profile_path, :study_groups_path

  def current_user
    # Ensure this logic correctly fetches your user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def user_signed_in?
    # This method relies on the current_user method
    !!current_user
  end

def profile_path
  # 1. Handle the "not logged in" case first
  return root_path unless current_user

  # 2. Use a case statement to cleanly check the role
  case current_user.role
  when 'teacher'
    # FIX: Changed to use the actual generated index path
    teacher_account_path 
  when 'student'
    # FIX: Changed to use the actual generated index path
    student_account_path
  else
    # Fallback for logged-in user with an undefined role
    root_path
  end
end

def authorize_user
  # 1. First, check if the user is signed in at all
  unless user_signed_in?
    # This might be redirecting you to root_path if you aren't signed in
    redirect_to sign_in_path and return
  end
  
  # 2. Check for role match based on the controller name
  if params[:controller] == 'studentaccount'
    # THIS IS THE LIKELY FAILURE POINT:
    unless current_user.role == 'student'
      redirect_to root_path and return # <-- Causes the redirect to home page
    end
  elsif params[:controller] == 'teacheraccount'
    # This check is succeeding for the teacher, so it continues
    unless current_user.role == 'teacher'
      redirect_to root_path and return
    end
  end
end

end
