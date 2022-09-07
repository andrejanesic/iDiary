json.extract! intake_entry, :id, :consumed, :note, :timestamp, :diary_id, :created_at, :updated_at
json.url intake_entry_url(intake_entry, format: :json)
