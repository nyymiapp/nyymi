json.array!(@open_jobs) do |open_job|
  json.extract! open_job, :id, :company_id, :name, :description, :expires
  json.url open_job_url(open_job, format: :json)
end
