require "test_helper"

class IntakeEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @intake_entry = intake_entries(:one)
  end

  test "should get index" do
    get intake_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_intake_entry_url
    assert_response :success
  end

  test "should create intake_entry" do
    assert_difference("IntakeEntry.count") do
      post intake_entries_url, params: { intake_entry: { consumed: @intake_entry.consumed, diary_id: @intake_entry.diary_id, note: @intake_entry.note, timestamp: @intake_entry.timestamp } }
    end

    assert_redirected_to intake_entry_url(IntakeEntry.last)
  end

  test "should show intake_entry" do
    get intake_entry_url(@intake_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_intake_entry_url(@intake_entry)
    assert_response :success
  end

  test "should update intake_entry" do
    patch intake_entry_url(@intake_entry), params: { intake_entry: { consumed: @intake_entry.consumed, diary_id: @intake_entry.diary_id, note: @intake_entry.note, timestamp: @intake_entry.timestamp } }
    assert_redirected_to intake_entry_url(@intake_entry)
  end

  test "should destroy intake_entry" do
    assert_difference("IntakeEntry.count", -1) do
      delete intake_entry_url(@intake_entry)
    end

    assert_redirected_to intake_entries_url
  end
end
