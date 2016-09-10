json.extract! artwork, :id, :source_file, :style_id, :output_file, :status, :created_at, :updated_at
json.url artwork_url(artwork, format: :json)