class CreateBodyEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :body_entries do |t|
      t.float :height
      t.float :weight
      t.float :fat_mass
      t.float :muscle_mass
      t.text :note
      t.datetime :timestamp
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
