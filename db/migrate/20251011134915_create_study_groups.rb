class CreateStudyGroups < ActiveRecord::Migration[8.0]
  def change
    create_table :study_groups do |t|
      t.string :studygroup

      t.timestamps
    end
  end
end
