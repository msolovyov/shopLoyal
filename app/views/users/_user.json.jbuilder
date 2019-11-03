json.extract! user, :id, :email, :multiplier, :created_at, :updated_at
json.url user_url(user, format: :json)
