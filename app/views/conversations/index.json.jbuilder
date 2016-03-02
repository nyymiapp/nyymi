json.array!(@conversations) do |conversation|
  json.extract! conversation, :id, :user_id, :company_id
  json.url conversation_url(conversation, format: :json)
end
