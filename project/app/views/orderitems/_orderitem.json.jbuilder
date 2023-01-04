json.extract! orderitem, :id, :order_id, :title, :price, :num, :image, :created_at, :updated_at
json.url orderitem_url(orderitem, format: :json)
