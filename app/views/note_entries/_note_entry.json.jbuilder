json.extract! note_entry, :id, :note, :timestamp, :diary_id, :created_at, :updated_at
json.url note_entry_url(note_entry, format: :json)
