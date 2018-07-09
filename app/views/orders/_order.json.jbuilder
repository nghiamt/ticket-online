json.extract! order, :id, :receiver_name, :receiver_address, :total_amount, :status, :user_id, :created_at, :updated_at
json.url order_url(order, format: :json)
