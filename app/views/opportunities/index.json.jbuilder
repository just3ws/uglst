# frozen_string_literal: true
json.array!(@opportunities) do |opportunity|
  json.extract! opportunity, :id
  json.url opportunity_url(opportunity, format: :json)
end
