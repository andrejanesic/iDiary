class CreateFoodSimples < ActiveRecord::Migration[7.0]
  def change
    create_table :food_simples do |t|
      t.string :name
      t.float :calories
      t.float :fats
      t.float :carbs
      t.float :proteins
      t.boolean :is_drink
      t.float :amount
      t.boolean :verified
      t.boolean :public
      t.text :description
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end

    add_index :food_simples, :name, unique: true
  end
end
