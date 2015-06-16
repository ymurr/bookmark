json.array!(@comments) do |comment|
  json.extract! comment, :id, :author, :content, :rating, :movie_id
  json.url comment_url(comment, format: :json)
end
