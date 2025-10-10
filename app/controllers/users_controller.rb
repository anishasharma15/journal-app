class UsersController < ApplicationController
  before_action :require_user_logged_in, only: %i[edit update]

  # GET /users/new
  # Displays the user registration form.
  def new
     # Use the correct helper we defined previously to check login status
     if user_signed_in?
      flash[:info] = "You are already signed in."
      redirect_to root_path # Or wherever you want to send them
    end
    @user = User.new
  end

  # GET /users/edit
  # Displays the user profile edit form.
  def edit
    # ... (content remains the same, assuming current_user is defined) ...
  end

  # POST /users
  # Creates a new user based on the submitted parameters.
def create
  @user = User.new(user_params) # Initializes user with username, email, password
  
  # *** MISSING ROLE ASSIGNMENT HERE ***
  
  if @user.save
    # ... redirects
  else
    # ... renders :new
  end
end
And your permitted parameters (user_params) also do not include :role:

Ruby

# UsersController#user_params
def user_params
  params.require(:user).permit(:username, :email, :password) # <-- :role is missing
end
When a user signs up using this controller, the role field in the database is left as nil, which is why your sign-in logic was redirecting the user to root_path.

The Fix: Set the Role During Sign-Up
Assuming this controller is exclusively for signing up students (which seems logical based on your application structure), you need to explicitly set the role before saving.

1. Update UsersController#create
Since this is the general sign-up controller, you need a way to assign the role. If all users signing up here are meant to be students, set the role directly in the controller:

Ruby

# app/controllers/users_controller.rb

def create
  # The 'new' action might involve a form asking for role, 
  # but since it's not in user_params, we'll assume a default role for this controller.
  
  @user = User.new(user_params)
  
  # --- ADD THIS LINE TO SET THE DEFAULT ROLE ---
  # If this controller is for students, set role to 'student'
  # If you have another way to determine the role (e.g., a hidden field), 
  # you'd need to permit it below.
  @user.role = 'student' 
  
  if @user.save
    reset_session
    session[:user_id] = @user.id 
    redirect_to welcome_path(locale: I18n.locale), notice: I18n.t('users.signed_up')
  else
    render :new, status: :unprocessable_content
  end
end

# --- DO NOT add :role to user_params if you set it manually like this ---
private
def user_params
  params.require(:user).permit(:username, :email, :password)
end

  # PATCH /users
  # Updates the current user's profile based on the submitted parameters.
  def update
    # ... (content remains the same, assuming current_user is defined) ...
  end

  private
  
  # A helper to ensure a user is logged in before editing/updating
  def require_user_logged_in
    unless user_signed_in?
      flash[:alert] = "You must be logged in to access this page."
      redirect_to sign_in_path # Redirect to your login page
    end
  end

  # Strong parameters for user creation.
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end