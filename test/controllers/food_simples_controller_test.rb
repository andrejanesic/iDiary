require "test_helper"

class FoodSimplesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_simple = food_simples(:one)
  end

  test "should get index" do
    get food_simples_url
    assert_response :success
  end

  test "should get new" do
    get new_food_simple_url
    assert_response :success
  end

  test "should create food_simple" do
    assert_difference("FoodSimple.count") do
      post food_simples_url, params: { food_simple: { amount: @food_simple.amount, calories: @food_simple.calories, carbs: @food_simple.carbs, description: @food_simple.description, fats: @food_simple.fats, is_drink: @food_simple.is_drink, name: @food_simple.name, proteins: @food_simple.proteins, public: @food_simple.public, user_id: @food_simple.user_id, verified: @food_simple.verified } }
    end

    assert_redirected_to food_simple_url(FoodSimple.last)
  end

  test "should show food_simple" do
    get food_simple_url(@food_simple)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_simple_url(@food_simple)
    assert_response :success
  end

  test "should update food_simple" do
    patch food_simple_url(@food_simple), params: { food_simple: { amount: @food_simple.amount, calories: @food_simple.calories, carbs: @food_simple.carbs, description: @food_simple.description, fats: @food_simple.fats, is_drink: @food_simple.is_drink, name: @food_simple.name, proteins: @food_simple.proteins, public: @food_simple.public, user_id: @food_simple.user_id, verified: @food_simple.verified } }
    assert_redirected_to food_simple_url(@food_simple)
  end

  test "should destroy food_simple" do
    assert_difference("FoodSimple.count", -1) do
      delete food_simple_url(@food_simple)
    end

    assert_redirected_to food_simples_url
  end
end
