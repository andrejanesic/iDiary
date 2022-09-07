require "test_helper"

class BodyEntriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @body_entry = body_entries(:one)
  end

  test "should get index" do
    get body_entries_url
    assert_response :success
  end

  test "should get new" do
    get new_body_entry_url
    assert_response :success
  end

  test "should create body_entry" do
    assert_difference("BodyEntry.count") do
      post body_entries_url, params: { body_entry: { diary_id: @body_entry.diary_id, fat_mass: @body_entry.fat_mass, height: @body_entry.height, muscle_mass: @body_entry.muscle_mass, note: @body_entry.note, timestamp: @body_entry.timestamp, weight: @body_entry.weight } }
    end

    assert_redirected_to body_entry_url(BodyEntry.last)
  end

  test "should show body_entry" do
    get body_entry_url(@body_entry)
    assert_response :success
  end

  test "should get edit" do
    get edit_body_entry_url(@body_entry)
    assert_response :success
  end

  test "should update body_entry" do
    patch body_entry_url(@body_entry), params: { body_entry: { diary_id: @body_entry.diary_id, fat_mass: @body_entry.fat_mass, height: @body_entry.height, muscle_mass: @body_entry.muscle_mass, note: @body_entry.note, timestamp: @body_entry.timestamp, weight: @body_entry.weight } }
    assert_redirected_to body_entry_url(@body_entry)
  end

  test "should destroy body_entry" do
    assert_difference("BodyEntry.count", -1) do
      delete body_entry_url(@body_entry)
    end

    assert_redirected_to body_entries_url
  end
end
