json.extract! cart, :id, :blog_id, :user_id, :num, :created_at, :updated_at
json.url cart_url(cart, format: :json)
