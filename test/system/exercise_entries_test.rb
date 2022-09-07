require "application_system_test_case"

class ExerciseEntriesTest < ApplicationSystemTestCase
  setup do
    @exercise_entry = exercise_entries(:one)
  end

  test "visiting the index" do
    visit exercise_entries_url
    assert_selector "h1", text: "Exercise entries"
  end

  test "should create exercise entry" do
    visit exercise_entries_url
    click_on "New exercise entry"

    check "Complete" if @exercise_entry.complete
    fill_in "Diary", with: @exercise_entry.diary_id
    fill_in "Note", with: @exercise_entry.note
    fill_in "Timestamp", with: @exercise_entry.timestamp
    click_on "Create Exercise entry"

    assert_text "Exercise entry was successfully created"
    click_on "Back"
  end

  test "should update Exercise entry" do
    visit exercise_entry_url(@exercise_entry)
    click_on "Edit this exercise entry", match: :first

    check "Complete" if @exercise_entry.complete
    fill_in "Diary", with: @exercise_entry.diary_id
    fill_in "Note", with: @exercise_entry.note
    fill_in "Timestamp", with: @exercise_entry.timestamp
    click_on "Update Exercise entry"

    assert_text "Exercise entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Exercise entry" do
    visit exercise_entry_url(@exercise_entry)
    click_on "Destroy this exercise entry", match: :first

    assert_text "Exercise entry was successfully destroyed"
  end
end
