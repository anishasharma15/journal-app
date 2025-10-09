class CreateUploads < ActiveRecord::Migration[8.0]
  def change
    create_table :uploads do |t|
      t.string :Files
      t.string :or
      t.string :Link
      t.string :upload_files_link

      t.timestamps
    end
  end
end
