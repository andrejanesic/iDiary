json.extract! diary_share, :id, :permission, :diary_id, :user_id, :created_at, :updated_at
json.url diary_share_url(diary_share, format: :json)
