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
    @user = User.new(user_params)
    if @user.save
      # Use your custom session key: session[:user_id]
      reset_session
      session[:user_id] = @user.id 
      # Note: I'm guessing 'welcome_path' is correct here.
      redirect_to welcome_path(locale: I18n.locale), notice: I18n.t('users.signed_up')
    else
      render :new, status: :unprocessable_content
    end
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