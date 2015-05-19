if photo.nil?
  json.null!
else
  json.extract! photo, :id, :creator, :title, :s3_key, :url, :thumb_s3_key, :thumb_url, :processed_at, :created_at, :updated_at
  json.photo_url photo_url(photo, format: :json)
end
