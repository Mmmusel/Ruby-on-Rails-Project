json.extract! order, :id, :user_id, :business_id, :order_name, :order_address, :order_mobile, :order_status, :order_sum, :created_at, :updated_at
json.url order_url(order, format: :json)
