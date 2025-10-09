class AddFieldsToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :title, :string
    add_column :resources, :description, :text
    add_column :resources, :upload_file_or_link, :string
  end
end
