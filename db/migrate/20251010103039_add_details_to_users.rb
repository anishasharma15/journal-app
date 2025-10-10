class AddDetailsToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :subject, :string
    add_column :users, :grade_level, :string
  end
end
