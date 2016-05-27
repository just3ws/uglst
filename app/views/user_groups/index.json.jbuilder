# frozen_string_literal: true
json.array!(@user_groups) do |user_group|
  json.extract! user_group, :id, :name, :city, :state_province, :country, :latitude, :longitude, :slug, :homepage, :twitter, :description, :registered_by_id
  json.url user_group_url(user_group, format: :json)
end
