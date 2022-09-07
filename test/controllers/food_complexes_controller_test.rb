require "test_helper"

class FoodComplexesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @food_complex = food_complexes(:one)
  end

  test "should get index" do
    get food_complexes_url
    assert_response :success
  end

  test "should get new" do
    get new_food_complex_url
    assert_response :success
  end

  test "should create food_complex" do
    assert_difference("FoodComplex.count") do
      post food_complexes_url, params: { food_complex: { description: @food_complex.description, name: @food_complex.name, public: @food_complex.public, template: @food_complex.template, user_id: @food_complex.user_id, verified: @food_complex.verified } }
    end

    assert_redirected_to food_complex_url(FoodComplex.last)
  end

  test "should show food_complex" do
    get food_complex_url(@food_complex)
    assert_response :success
  end

  test "should get edit" do
    get edit_food_complex_url(@food_complex)
    assert_response :success
  end

  test "should update food_complex" do
    patch food_complex_url(@food_complex), params: { food_complex: { description: @food_complex.description, name: @food_complex.name, public: @food_complex.public, template: @food_complex.template, user_id: @food_complex.user_id, verified: @food_complex.verified } }
    assert_redirected_to food_complex_url(@food_complex)
  end

  test "should destroy food_complex" do
    assert_difference("FoodComplex.count", -1) do
      delete food_complex_url(@food_complex)
    end

    assert_redirected_to food_complexes_url
  end
end
