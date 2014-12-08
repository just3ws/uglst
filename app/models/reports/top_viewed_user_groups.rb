module Reports
  class TopViewedUserGroups
def run

      Metric.where(request_controller: 'user_groups').
        pluck(:request_params).map do |data|
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
