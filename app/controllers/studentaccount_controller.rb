class StudentaccountController < ApplicationController

  def index
    # Only need the join records with eager-loaded resources
    @saved_resource_joins = current_user.saved_resources.includes(:resource).order(created_at: :desc)
  end

end
