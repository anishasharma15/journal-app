class StudyGroupsController < ApplicationController
    def index
        @study_groups = StudyGroup.all
    end
    
    def show
        @study_group = StudyGroup.find(params[:id])
    end
    
    def new
        @study_group = StudyGroup.new
    end
    
    def create
        @study_group = StudyGroup.new(study_group_params)
        if @study_group.save
        flash[:success] = "Study group created successfully!"
        redirect_to study_groups_path
        else
        render :new, status: :unprocessable_entity
        end
    end
    
    private
    
    def study_group_params
        params.require(:study_group).permit(:name, :subject, :grade_level, :description)
    end
end
