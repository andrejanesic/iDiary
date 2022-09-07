class CreateGoals < ActiveRecord::Migration[7.0]
  def change
    create_table :goals do |t|
      t.boolean :active
      t.float :calories
      t.float :fats
      t.float :carbs
      t.float :proteins
      t.string :frequency
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
