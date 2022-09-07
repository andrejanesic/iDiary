require "application_system_test_case"

class DiarySharesTest < ApplicationSystemTestCase
  setup do
    @diary_share = diary_shares(:one)
  end

  test "visiting the index" do
    visit diary_shares_url
    assert_selector "h1", text: "Diary shares"
  end

  test "should create diary share" do
    visit diary_shares_url
    click_on "New diary share"

    fill_in "Diary", with: @diary_share.diary_id
    fill_in "Permission", with: @diary_share.permission
    fill_in "User", with: @diary_share.user_id
    click_on "Create Diary share"

    assert_text "Diary share was successfully created"
    click_on "Back"
  end

  test "should update Diary share" do
    visit diary_share_url(@diary_share)
    click_on "Edit this diary share", match: :first

    fill_in "Diary", with: @diary_share.diary_id
    fill_in "Permission", with: @diary_share.permission
    fill_in "User", with: @diary_share.user_id
    click_on "Update Diary share"

    assert_text "Diary share was successfully updated"
    click_on "Back"
  end

  test "should destroy Diary share" do
    visit diary_share_url(@diary_share)
    click_on "Destroy this diary share", match: :first

    assert_text "Diary share was successfully destroyed"
  end
end
