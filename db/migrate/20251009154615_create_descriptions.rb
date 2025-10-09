class CreateDescriptions < ActiveRecord::Migration[8.0]
  def change
    create_table :descriptions do |t|
      t.string :description

      t.timestamps
    end
  end
end
