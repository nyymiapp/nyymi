json.array!(@open_jobs) do |open_job|
  if open_job.expires > DateTime.now and current_user.open_jobs.include? open_job
    json.extract! open_job, :id, :company_id, :name, :description, :expires
    json.company do
      json.name open_job.company.name
    end
    json.company do
      json.location open_job.company.location
    end
    json.company do
      json.id open_job.company.id
    end
    #json.url open_job_url(open_job, format: :json)
  end
end