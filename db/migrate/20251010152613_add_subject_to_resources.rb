class AddSubjectToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :subject, :string
  end
end
