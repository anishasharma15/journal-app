class CreateSavedResources < ActiveRecord::Migration[8.0]
  def change
    create_table :saved_resources do |t|
      t.references :user, null: false, foreign_key: true
      t.references :resource, null: false, foreign_key: true

      t.timestamps
    end
  end
end
