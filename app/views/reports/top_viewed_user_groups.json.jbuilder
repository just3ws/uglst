# frozen_string_literal: true
json.array!(@top_viewed_user_groups) do |top_viewed_user_group|
  json.id top_viewed_user_group.last
  json.count top_viewed_user_group.first
end
