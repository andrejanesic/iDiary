require "application_system_test_case"

class NoteEntriesTest < ApplicationSystemTestCase
  setup do
    @note_entry = note_entries(:one)
  end

  test "visiting the index" do
    visit note_entries_url
    assert_selector "h1", text: "Note entries"
  end

  test "should create note entry" do
    visit note_entries_url
    click_on "New note entry"

    fill_in "Diary", with: @note_entry.diary_id
    fill_in "Note", with: @note_entry.note
    fill_in "Timestamp", with: @note_entry.timestamp
    click_on "Create Note entry"

    assert_text "Note entry was successfully created"
    click_on "Back"
  end

  test "should update Note entry" do
    visit note_entry_url(@note_entry)
    click_on "Edit this note entry", match: :first

    fill_in "Diary", with: @note_entry.diary_id
    fill_in "Note", with: @note_entry.note
    fill_in "Timestamp", with: @note_entry.timestamp
    click_on "Update Note entry"

    assert_text "Note entry was successfully updated"
    click_on "Back"
  end

  test "should destroy Note entry" do
    visit note_entry_url(@note_entry)
    click_on "Destroy this note entry", match: :first

    assert_text "Note entry was successfully destroyed"
  end
end
