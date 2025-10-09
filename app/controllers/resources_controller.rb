class ResourcesController < ApplicationController
   
    def browse
       @resources = Resource.all
    end
   
    def index
        @resources = Resource.all
   end

   def new
        @resource = Resource.new()
   end

   def create
        @resource = Resource.new(resource_params)
        if @resource.save
            redirect_to browse_resources_path, notice: "Resource successfully created!"
        else
            render :new
        end
   end

   def index
       @resources = Resource.all

   def destroy
       Resource.find(params[:id]).destroy
       redirect_to root_url
   end


   def resource_params
       params.require(:resource).permit(:title, :description, :upload_file_or_link)
   end

end
    end

   private
    def resource_params
        params.require(:resource).permit(:title, :description, :upload_file_or_link)
    end

    