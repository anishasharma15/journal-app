class ResourcesController < ApplicationController
  # List all resources (browse page)
  def browse
    @resources = Resource.all
  end

  # Standard index (optional, can alias to browse)
  def index
    @resources = Resource.all
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

  private

  # Strong parameters
  def resource_params
    params.require(:resource).permit(:title, :description, :upload_file_or_link)
  end
end
