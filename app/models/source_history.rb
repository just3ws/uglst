class SourceHistory < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  default_scope { order('created_at ASC') }

  belongs_to :source
  belongs_to :user_group

  validates :source, presence: true
  validates :user_group, presence: true
end

# == Schema Information
#
# Table name: source_histories
#
#  id                :uuid             not null, primary key
#  source_id         :uuid
#  user_group_id     :uuid
#  remote_identifier :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#
