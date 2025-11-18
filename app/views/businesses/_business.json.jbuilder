json.extract! business, :id, :name, :address, :email, :phone, :created_at, :updated_at
json.url business_url(business, format: :json)
