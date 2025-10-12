class TeacheraccountController < ApplicationController
  def index
    # Load ALL resources associated with the current user (teacher)
    @resources = current_user.resources.order(created_at: :desc) # Optional: show newest first
    
    # Apply filtering logic only if parameters are present
    if params[:subject].present?
      @resources = @resources.where(subject: params[:subject])
    end

    if params[:level].present?
      @resources = @resources.where(level: params[:level])
    end

    if params[:resource_type].present?
      @resources = @resources.where(resource_type: params[:resource_type])
    end
    
    # Note: If you have filtering logic in the view's form_with that points to this
    # controller, the filtering logic above needs to stay. Otherwise, it should 
    # just be `@resources = current_user.resources`.
  end
end
