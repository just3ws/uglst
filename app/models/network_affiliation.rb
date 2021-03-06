# frozen_string_literal: true
class NetworkAffiliation < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  default_scope { order('created_at ASC') }

  belongs_to :network
  belongs_to :user_group

  validates :network, presence: true
  validates :user_group, presence: true
end

# == Schema Information
#
# Table name: network_affiliations
#
#  id            :uuid             not null, primary key
#  network_id    :uuid
#  user_group_id :uuid
#  created_at    :datetime
#  updated_at    :datetime
#
