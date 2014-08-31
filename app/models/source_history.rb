class SourceHistory < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  default_scope -> { order('created_at ASC') }

  belongs_to :source
  belongs_to :user_group

  validates :source, presence: true
  validates :user_group, presence: true
end

# == Schema Information
# Schema version: 20140831020534
#
# Table name: source_histories
#
#  id            :uuid             not null, primary key
#  source_id     :uuid
#  user_group_id :uuid
#  created_at    :datetime
#  updated_at    :datetime
#
