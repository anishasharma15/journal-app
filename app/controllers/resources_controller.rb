class ResourcesController < ApplicationController
  
  # List all resources (browse page) - This will be the main display action
  def browse
    # Use the combined method from the model to handle keyword search and all filters
    @resources = Resource.search_and_filter(params)
    
    # Note: If you have a separate 'index' view, you can either remove it 
    # or alias it to this 'browse' action in your routes.
  end

  # Standard index (optional, can alias to browse) - Logic removed as 'browse' handles it
  # If you use 'index' in your routes, it's best to keep this action, 
  # but simplify it to call the same logic as browse.
  def index
    # We delegate filtering logic to the 'browse' action's implementation
    # Note: In a real app, you would likely just make one of these primary.
    @resources = Resource.search_and_filter(params)
  end

  # Form for new resource
  def new
    @resource = Resource.new
  end

  # Handle form submission
  def create
    @resource = Resource.new(resource_params)
    if @resource.save
      redirect_to browse_resources_path, notice: "Resource successfully created!"
    else
      render :new
    end
  end

  # Form to edit an existing resource
  def edit
    @resource = Resource.find(params[:id])
      if @resource.nil?
    redirect_to browse_resources_path, alert: "Resource not found."
  end
  end

  # Handle update submission
  def update
    @resource = Resource.find(params[:id])
    if @resource.update(resource_params)
      redirect_to browse_resources_path, notice: "Resource successfully updated!"
    else
      render :edit
    end
  end

  # Delete a resource
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy
    redirect_to browse_resources_path, notice: "Resource deleted successfully."
  end

  def show
    @resource = Resource.find(params[:id]) 
  end

  # REMOVED DUPLICATE 'browse' METHOD HERE

  private

  # Strong parameters
  def resource_params
    params.require(:resource).permit(:title, :subject, :grade_level, :resource_type, :description, :upload_file_or_link)
  end
end
