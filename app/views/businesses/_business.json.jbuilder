json.extract! business, :id, :name, :address, :email, :phone, :url, :created_at, :updated_at
json.url business_url(business, format: :json)
