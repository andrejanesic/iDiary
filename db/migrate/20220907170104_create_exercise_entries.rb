class CreateExerciseEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :exercise_entries do |t|
      t.boolean :complete
      t.text :note
      t.datetime :timestamp
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
