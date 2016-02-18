json.array!(@applications) do |application|
  json.extract! application, :id, :open_job_id, :user_id
  json.url application_url(application, format: :json)
end
