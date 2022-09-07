require "application_system_test_case"

class IntakeEntriesTest < ApplicationSystemTestCase
  setup do
    @intake_entry = intake_entries(:one)
  end

  test "visiting the index" do
    visit intake_entries_url
    assert_selector "h1", text: "Intake entries"
  end

  test "should create intake entry" do
    visit intake_entries_url
    click_on "New intake entry"

    check "Consumed" if @intake_entry.consumed
    fill_in "Diary", with: @intake_entry.diary_id
    fill_in "Note", with: @intake_entry.note
    fill_in "Timestamp", with: @intake_entry.timestamp
    click_on "Create Intake entry"

    assert_text "Intake entry was successfully created"
    click_on "Back"
  end

  test "should update Intake entry" do
    visit intake_entry_url(@intake_entry)
    click_on "Edit this intake entry", match: :first

    check "Consumed" if @intake_entry.consumed
    fill_in "Diary", with: @intake_entry.diary_id
    fill_in "Note", with: @intake_entry.note
    fill_in "Timestamp", with: @intake_entry.timestamp
    click_on "Update Intake entry"

    assert_text "Intake entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Intake entry" do
    visit intake_entry_url(@intake_entry)
    click_on "Destroy this intake entry", match: :first

    assert_text "Intake entry was successfully destroyed"
  end
end
