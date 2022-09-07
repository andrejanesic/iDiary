require "test_helper"

class ExerciseEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exercise_entry = exercise_entries(:one)
  end

  test "should get index" do
    get exercise_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_exercise_entry_url
    assert_response :success
  end

  test "should create exercise_entry" do
    assert_difference("ExerciseEntry.count") do
      post exercise_entries_url, params: { exercise_entry: { complete: @exercise_entry.complete, diary_id: @exercise_entry.diary_id, note: @exercise_entry.note, timestamp: @exercise_entry.timestamp } }
    end

    assert_redirected_to exercise_entry_url(ExerciseEntry.last)
  end

  test "should show exercise_entry" do
    get exercise_entry_url(@exercise_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_exercise_entry_url(@exercise_entry)
    assert_response :success
  end

  test "should update exercise_entry" do
    patch exercise_entry_url(@exercise_entry), params: { exercise_entry: { complete: @exercise_entry.complete, diary_id: @exercise_entry.diary_id, note: @exercise_entry.note, timestamp: @exercise_entry.timestamp } }
    assert_redirected_to exercise_entry_url(@exercise_entry)
  end

  test "should destroy exercise_entry" do
    assert_difference("ExerciseEntry.count", -1) do
      delete exercise_entry_url(@exercise_entry)
    end

    assert_redirected_to exercise_entries_url
  end
end
