json.extract! body_entry, :id, :weight, :height, :fat_mass, :muscle_mass, :note, :diary_id, :created_at, :updated_at
json.url body_entry_url(body_entry, format: :json)
