require "application_system_test_case"

class FoodSimplesTest < ApplicationSystemTestCase
  setup do
    @food_simple = food_simples(:one)
  end

  test "visiting the index" do
    visit food_simples_url
    assert_selector "h1", text: "Food simples"
  end

  test "should create food simple" do
    visit food_simples_url
    click_on "New food simple"

    fill_in "Amount", with: @food_simple.amount
    fill_in "Calories", with: @food_simple.calories
    fill_in "Carbs", with: @food_simple.carbs
    fill_in "Description", with: @food_simple.description
    fill_in "Fats", with: @food_simple.fats
    check "Is drink" if @food_simple.is_drink
    fill_in "Name", with: @food_simple.name
    fill_in "Proteins", with: @food_simple.proteins
    check "Public" if @food_simple.public
    fill_in "User", with: @food_simple.user_id
    check "Verified" if @food_simple.verified
    click_on "Create Food simple"

    assert_text "Food simple was successfully created"
    click_on "Back"
  end

  test "should update Food simple" do
    visit food_simple_url(@food_simple)
    click_on "Edit this food simple", match: :first

    fill_in "Amount", with: @food_simple.amount
    fill_in "Calories", with: @food_simple.calories
    fill_in "Carbs", with: @food_simple.carbs
    fill_in "Description", with: @food_simple.description
    fill_in "Fats", with: @food_simple.fats
    check "Is drink" if @food_simple.is_drink
    fill_in "Name", with: @food_simple.name
    fill_in "Proteins", with: @food_simple.proteins
    check "Public" if @food_simple.public
    fill_in "User", with: @food_simple.user_id
    check "Verified" if @food_simple.verified
    click_on "Update Food simple"

    assert_text "Food simple was successfully updated"
    click_on "Back"
  end

  test "should destroy Food simple" do
    visit food_simple_url(@food_simple)
    click_on "Destroy this food simple", match: :first

    assert_text "Food simple was successfully destroyed"
  end
end
