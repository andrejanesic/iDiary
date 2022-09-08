require "test_helper"

class NoteEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @note_entry = note_entries(:one)
  end

  test "should get index" do
    get note_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_note_entry_url
    assert_response :success
  end

  test "should create note_entry" do
    assert_difference("NoteEntry.count") do
      post note_entries_url, params: { note_entry: { diary_id: @note_entry.diary_id, note: @note_entry.note, timestamp: @note_entry.timestamp } }
    end

    assert_redirected_to note_entry_url(NoteEntry.last)
  end

  test "should show note_entry" do
    get note_entry_url(@note_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_note_entry_url(@note_entry)
    assert_response :success
  end

  test "should update note_entry" do
    patch note_entry_url(@note_entry), params: { note_entry: { diary_id: @note_entry.diary_id, note: @note_entry.note, timestamp: @note_entry.timestamp } }
    assert_redirected_to note_entry_url(@note_entry)
  end

  test "should destroy note_entry" do
    assert_difference("NoteEntry.count", -1) do
      delete note_entry_url(@note_entry)
    end

    assert_redirected_to note_entries_url
  end
end
