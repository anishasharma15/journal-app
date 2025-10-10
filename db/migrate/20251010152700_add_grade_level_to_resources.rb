class AddGradeLevelToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :grade_level, :string
  end
end
