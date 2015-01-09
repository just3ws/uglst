module Ahoy
  class Event < ActiveRecord::Base
    self.table_name = 'ahoy_events'

    belongs_to :visit
    belongs_to :user
  end
end

# == Schema Information
#
# Table name: ahoy_events
#
#  id         :uuid             not null, primary key
#  visit_id   :uuid
#  user_id    :uuid
#  name       :string(255)
#  properties :json
#  time       :datetime
#
