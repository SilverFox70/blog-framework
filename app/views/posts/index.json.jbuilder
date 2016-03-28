json.array!(@posts) do |post|
  json.extract! post, :id, :title, :date, :content, :category
  json.url post_url(post, format: :json)
end
