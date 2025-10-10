class Resource < ApplicationRecord
    def self.search_and_filter(params)
    resources = all
    query = params[:query]
    
    # 1. Keyword Search (using ILIKE for case-insensitive search)
    if query.present?
      sql_query = "title ILIKE :query OR subject ILIKE :query OR description ILIKE :query"
      resources = resources.where(sql_query, query: "%#{query}%")
    end
    
    # 2. Subject Filter
    if params[:subject].present?
      # Assuming subject column stores exact names (e.g., 'Maths', 'Science')
      resources = resources.where(subject: params[:subject])
    end
    
    # 3. Level Filter
    if params[:level].present?
      resources = resources.where(grade_level: params[:level]) # Note: Assuming the column is 'grade_level' based on previous context
    end

    # 4. Resource Type Filter
    if params[:resource_type].present?
      resources = resources.where(resource_type: params[:resource_type])
    end
    
    # Return the filtered collection
    return resources
  end
end
