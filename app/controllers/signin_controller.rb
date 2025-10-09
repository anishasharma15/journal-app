class SigninController < ApplicationController

  def new
    @user = User.new()
  end

 def create
    @user = User.find_by(email: params[:user][:email])

    if @user 
      session[:user_id] = @user.id
      redirect_to student_account_path
    else
      flash.now[:alert] = "Invalid email or password"
      @user = User.new # <-- important to reinitialize if login fails
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Signed out successfully!"
  end

  private

  def user_params
    params.require(:user).permit(:email,:password)
  end
end
