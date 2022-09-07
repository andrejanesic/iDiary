json.extract! exercise_entry, :id, :complete, :note, :timestamp, :diary_id, :created_at, :updated_at
json.url exercise_entry_url(exercise_entry, format: :json)
