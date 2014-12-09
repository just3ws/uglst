json.array!(@admin_opportunities) do |admin_opportunity|
  json.extract! admin_opportunity, :id
  json.url admin_opportunity_url(admin_opportunity, format: :json)
end
