class ResourcesController < ApplicationController
  
  # Ensure user is authenticated before performing actions (assuming you have auth set up)
  # before_action :authenticate_user! # Uncomment if using a gem like Devise

  # List all resources (browse page) - This will be the main display action
   def browse
    # Fetch all resources
    @resources = Resource.all

    # Safe: if user is logged in, get saved resource ids; else empty array
    @saved_resource_ids = current_user ? current_user.saved_resources.pluck(:resource_id) : []
  end

  # Standard index (optional, can alias to browse) - Logic removed as 'browse' handles it
  def index
    # We delegate filtering logic to the 'browse' action's implementation
    @resources = Resource.search_and_filter(params)
  end

  # Form for new resource
  def new
    @resource = Resource.new
  end

  # Handle form submission
  def create
    # CRITICAL FIX: Build the resource through the user association
    # This automatically assigns the current_user.id to the user_id column
    # If using Devise: @resource = current_user.resources.new(resource_params)
    @resource = current_user.resources.new(resource_params)

    if @resource.save
      redirect_to browse_resources_path, notice: "Resource successfully created!"
    else
      # If validation fails, render the new template
      # @resource will contain the validation errors
      render :new, status: :unprocessable_entity
    end
  end

  # Form to edit an existing resource
  def edit
    # Ensure the user can only edit resources they own
    @resource = Resource.find(params[:id])
    
    # Conditional logic is often safer than just setting @resource = nil
    unless @resource.user == current_user
      redirect_to browse_resources_path, alert: "You are not authorized to edit this resource."
    end
  end

  # Handle update submission
  def update
    @resource = Resource.find(params[:id])

    # SECURITY CHECK: Ensure user owns resource before updating
    unless @resource.user == current_user
      return redirect_to browse_resources_path, alert: "You are not authorized to update this resource."
    end

    if @resource.update(resource_params)
      redirect_to browse_resources_path, notice: "Resource successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # Delete a resource
  def destroy
    @resource = Resource.find(params[:id])
    
    # SECURITY CHECK: Ensure user owns resource before deleting
    unless @resource.user == current_user
      return redirect_to browse_resources_path, alert: "You are not authorized to delete this resource."
    end

    @resource.destroy
    redirect_to browse_resources_path, notice: "Resource deleted successfully."
  end

  def show
    @resource = Resource.find(params[:id]) 
  end

  private

  # Strong parameters
  def resource_params
    params.require(:resource).permit(
      :title, 
      :subject, 
      :grade_level, 
      :resource_type, 
      :description, 
      :upload_file_or_link
      # DO NOT include :user_id here, assign it in the controller for security
    )
  end
end
