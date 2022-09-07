require "application_system_test_case"

class FoodComplexesTest < ApplicationSystemTestCase
  setup do
    @food_complex = food_complexes(:one)
  end

  test "visiting the index" do
    visit food_complexes_url
    assert_selector "h1", text: "Food complexes"
  end

  test "should create food complex" do
    visit food_complexes_url
    click_on "New food complex"

    fill_in "Description", with: @food_complex.description
    fill_in "Name", with: @food_complex.name
    check "Public" if @food_complex.public
    check "Template" if @food_complex.template
    fill_in "User", with: @food_complex.user_id
    check "Verified" if @food_complex.verified
    click_on "Create Food complex"

    assert_text "Food complex was successfully created"
    click_on "Back"
  end

  test "should update Food complex" do
    visit food_complex_url(@food_complex)
    click_on "Edit this food complex", match: :first

    fill_in "Description", with: @food_complex.description
    fill_in "Name", with: @food_complex.name
    check "Public" if @food_complex.public
    check "Template" if @food_complex.template
    fill_in "User", with: @food_complex.user_id
    check "Verified" if @food_complex.verified
    click_on "Update Food complex"

    assert_text "Food complex was successfully updated"
    click_on "Back"
  end

  test "should destroy Food complex" do
    visit food_complex_url(@food_complex)
    click_on "Destroy this food complex", match: :first

    assert_text "Food complex was successfully destroyed"
  end
end
