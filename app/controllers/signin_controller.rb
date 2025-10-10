class SigninController < ApplicationController

  def new
    @user = User.new()
  end

  def create
    # 1. Find the user by email
    user = User.find_by(email: params[:user][:email].downcase) 

    if user.password == params[:user][:password_digest]
      
      # SUCCESSFUL LOGIN
      
      # Log the user in
      session[:user_id] = user.id

      # Redirect based on the user's role
      if user.role == 'teacher'
        flash[:success] = "Welcome back, Teacher!"
        redirect_to teacher_account_path
        
      elsif user.role == 'student'
        flash[:success] = "Welcome back, Student!"
        redirect_to student_account_path
        
      else
        # Fallback if role is not set
        flash[:success] = "Login successful!"
        redirect_to root_path
      end

    else
      # FAILED LOGIN
      flash.now[:alert] = "Invalid email or password combination"
    end

end

  
  def destroy
    # Handles sign out
    session[:user_id] = nil
    flash[:notice] = "You have been signed out."
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:email,:password)
  end

end
