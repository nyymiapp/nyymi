json.array!(@experiences) do |experience|
  json.extract! experience, :id, :application_id, :place, :description, :start, :end
  json.url experience_url(experience, format: :json)
end
