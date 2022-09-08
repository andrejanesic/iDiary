class CreateNoteEntries < ActiveRecord::Migration[7.0]
  def change
    create_table :note_entries do |t|
      t.text :note
      t.datetime :timestamp
      t.references :diary, null: false, foreign_key: true

      t.timestamps
    end
  end
end
