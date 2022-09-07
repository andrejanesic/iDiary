require "application_system_test_case"

class BodyEntriesTest < ApplicationSystemTestCase
  setup do
    @body_entry = body_entries(:one)
  end

  test "visiting the index" do
    visit body_entries_url
    assert_selector "h1", text: "Body entries"
  end

  test "should create body entry" do
    visit body_entries_url
    click_on "New body entry"

    fill_in "Diary", with: @body_entry.diary_id
    fill_in "Fat mass", with: @body_entry.fat_mass
    fill_in "Height", with: @body_entry.height
    fill_in "Muscle mass", with: @body_entry.muscle_mass
    fill_in "Note", with: @body_entry.note
    fill_in "Timestamp", with: @body_entry.timestamp
    fill_in "Weight", with: @body_entry.weight
    click_on "Create Body entry"

    assert_text "Body entry was successfully created"
    click_on "Back"
  end

  test "should update Body entry" do
    visit body_entry_url(@body_entry)
    click_on "Edit this body entry", match: :first

    fill_in "Diary", with: @body_entry.diary_id
    fill_in "Fat mass", with: @body_entry.fat_mass
    fill_in "Height", with: @body_entry.height
    fill_in "Muscle mass", with: @body_entry.muscle_mass
    fill_in "Note", with: @body_entry.note
    fill_in "Timestamp", with: @body_entry.timestamp
    fill_in "Weight", with: @body_entry.weight
    click_on "Update Body entry"

    assert_text "Body entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Body entry" do
    visit body_entry_url(@body_entry)
    click_on "Destroy this body entry", match: :first

    assert_text "Body entry was successfully destroyed"
  end
end
