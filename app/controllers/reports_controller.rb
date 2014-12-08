class ReportsController < ApplicationController
  def top_viewed_user_groups
    Metric

    @top_viewed_user_groups = Rails.cache.fetch('top_viewed_user_groups', expires: if Rails.env.production? then 1.hour else 0.seconds end) do
      Metric.where(request_controller: 'user_groups')
      .pluck(:request_params).map do |data|
        data['id']
      end.compact.group_by do |data|
        data
      end.map do |pair|
        [pair.last.count, pair.first]
      end.sort do |left, right|
        right.first <=> left.first
      end
    end
  end
end
