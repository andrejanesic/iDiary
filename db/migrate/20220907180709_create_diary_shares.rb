class CreateDiaryShares < ActiveRecord::Migration[7.0]
  def change
    create_table :diary_shares do |t|
      t.integer :permission
      t.references :diary, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
