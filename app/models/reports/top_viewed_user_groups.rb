# frozen_string_literal: true
module Reports
  class TopViewedUserGroups
    def run
      Metric
        .where(request_controller: 'user_groups')
        .pluck(:request_params).map { |data| data['id'] }
        .compact.group_by { |data| data }
        .map { |pair| [pair.last.count, pair.first] }
        .sort { |left, right| right.first <=> left.first }
    end
  end
end
