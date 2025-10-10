class CreateaccountController < ApplicationController

  def new
    @user = User.new  
  end

  def create
    # 1. Create the new account object using strong parameters
    @user = User.new(user_params) # Use your actual model name (e.g., User.new)

    if @user.save
        session[:user_id] = @user.id
      # 2. Check the saved role attribute (it will be 'teacher' or 'student')
      if @user.role == 'teacher'
        flash[:success] = "Teacher account successfully created! Welcome."
        redirect_to teacher_account_path

      elsif @user.role == 'student'
        flash[:success] = "Student account successfully created! Welcome."
        redirect_to student_account_path
        
      else
        # Fallback redirect if role is missing or unexpected
        flash[:success] = "Account created. Welcome!"
        redirect_to root_path
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

private

def user_params
    params.require(:user).permit(:name, :email, :password, :subject, :grade_level, :role)
end

end