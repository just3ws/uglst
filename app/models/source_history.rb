class SourceHistory < ActiveRecord::Base
  include PublicActivity::Model
  tracked owner: proc { |controller, _model| controller.current_user }

  default_scope -> { order('created_at ASC') }

  belongs_to :source
  belongs_to :user_group

  validates :source, presence: true
  validates :user_group, presence: true
end
