class ReportsController < ApplicationController
  def top_viewed_user_groups
    @top_viewed_user_groups = Rails.cache.fetch('top_viewed_user_groups', expires: Rails.env.production? ? 1.hour : 0.seconds) do
      Metric
      .where(request_controller: 'user_groups')
      .pluck(:request_params)
      .map { |data| data['id'] }
      .compact
      .group_by { |data| data }
      .map { |pair| [pair.last.count, pair.first] }
      .sort { |left, right| right.first <=> left.first }
    end
  end
end
