class SavedResourcesController < ApplicationController
  # POST /saved_resources
  def create
    resource = Resource.find(params[:resource_id])
    current_user.saved_resources.find_or_create_by(resource: resource)
    redirect_back fallback_location: browse_resources_path, notice: "Resource saved!"
  end

  # DELETE /saved_resources/:id
  def destroy
    saved = current_user.saved_resources.find(params[:id])
    saved.destroy
    redirect_back fallback_location: student_account_path, notice: "Resource removed."
  end
end
