json.array!(@companies) do |company|
  json.extract! company, :id, :name, :description, :location
  json.url company_url(company, format: :json)
end
