json.array!(@logs) do |log|
  json.extract! log, :id, :count, :date
  json.url log_url(log, format: :json)
end
