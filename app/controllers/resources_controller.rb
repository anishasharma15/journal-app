class ResourcesController < ApplicationController
   def index
        @resources = Resource.all
   end

   def new
        @resource = Resource.new()
   end

   def create
        @resource = Resource.new(resource_params)
        if @resource.save
            redirect_to browse_resources_url
        else
            render :new
        end
   end

   def destroy
       Resource.find(params[:id]).destroy
       redirect_to root_url
   end

   private

   def resource_params
       params.require(:resource).permit(:name, :link)
   end

end
