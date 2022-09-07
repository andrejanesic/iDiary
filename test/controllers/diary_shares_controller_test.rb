require "test_helper"

class DiarySharesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @diary_share = diary_shares(:one)
  end

  test "should get index" do
    get diary_shares_url
    assert_response :success
  end

  test "should get new" do
    get new_diary_share_url
    assert_response :success
  end

  test "should create diary_share" do
    assert_difference("DiaryShare.count") do
      post diary_shares_url, params: { diary_share: { diary_id: @diary_share.diary_id, permission: @diary_share.permission, user_id: @diary_share.user_id } }
    end

    assert_redirected_to diary_share_url(DiaryShare.last)
  end

  test "should show diary_share" do
    get diary_share_url(@diary_share)
    assert_response :success
  end

  test "should get edit" do
    get edit_diary_share_url(@diary_share)
    assert_response :success
  end

  test "should update diary_share" do
    patch diary_share_url(@diary_share), params: { diary_share: { diary_id: @diary_share.diary_id, permission: @diary_share.permission, user_id: @diary_share.user_id } }
    assert_redirected_to diary_share_url(@diary_share)
  end

  test "should destroy diary_share" do
    assert_difference("DiaryShare.count", -1) do
      delete diary_share_url(@diary_share)
    end

    assert_redirected_to diary_shares_url
  end
end
