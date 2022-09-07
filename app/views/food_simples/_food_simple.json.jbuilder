json.extract! food_simple, :id, :name, :calories, :fats, :carbs, :proteins, :is_drink, :amount, :verified, :public, :description, :user_id, :created_at, :updated_at
json.url food_simple_url(food_simple, format: :json)
