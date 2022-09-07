class CreateFoodComplexes < ActiveRecord::Migration[7.0]
  def change
    create_table :food_complexes do |t|
      t.string :name
      t.text :description
      t.boolean :template
      t.boolean :verified
      t.boolean :public
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :food_complexes, :name, unique: true
  end
end
