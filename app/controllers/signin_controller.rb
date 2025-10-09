class SigninController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: signin_params[:email])
        if user && user.authenticate(signin_params[:password])
            session[:user_id] = user.id
            redirect_to student_account_url, notice: "Signed in successfully!"
        else
            flash.now[:alert] = "Invalid email or password."
            render :new, status: :unprocessable_entity
        end
  end

  def destroy
  end

  private

    def signin_params
        params.require(:user).permit(:email, :password) 
    end

end