class AddResourceTypeToResources < ActiveRecord::Migration[8.0]
  def change
    add_column :resources, :resource_type, :string
  end
end
