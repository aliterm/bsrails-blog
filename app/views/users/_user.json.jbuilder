json.extract! user, :id, :email, :pasword, :name, :role, :created_at, :updated_at
json.url user_url(user, format: :json)
