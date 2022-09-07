json.extract! body_entry, :id, :height, :weight, :fat_mass, :muscle_mass, :note, :timestamp, :diary_id, :created_at, :updated_at
json.url body_entry_url(body_entry, format: :json)
