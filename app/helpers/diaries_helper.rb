module DiariesHelper
  def diary_belongs_to_user(diary_id, user_id)
    Diary.find(diary_id).user_id == user_id
  rescue StandardError => e
    false
  end
end
