module ApplicationHelper
  # This line resolves the path helper NameErrors
  include Rails.application.routes.url_helpers

  def profile_path
    return root_path unless current_user

    case current_user.role
    when 'teacher'
      teacher_account_index_path 
    when 'student'
      student_account_index_path
    else
      root_path
    end
  end
end
