class Feature < ActiveRecord::Base
  include Bitfields
  # Required Roles
  # 01 0001 guest
  # 02 0010 registered
  # 04 0100 admin
  bitfield :rules, 1 => :guest, 2 => :registered, 4 => :admin

  validates_uniqueness_of :name
  validates_length_of     :name, maximum: 32, allow_blank: false, minimum: 1
  validates_length_of     :description, maximum: 1024, allow_blank: true

  before_validation :format_name

  class << self
    def ok?(feature_name)
      Feature.find_by_name(format_name(feature_name)).try(:enabled?)
    end

    def ok!(feature_name, enabled = false, description = '')
      Feature.find_or_create_by_name(format_name(feature_name)) do |feature|
        feature.enabled = !!enabled
        feature.description = description.squish!
      end.enabled?
    end

    def format_name(feature_name)
      feature_name.to_s.underscore.gsub(/\s/, '_').gsub(/\W/, '').gsub(/_+/, '_').gsub(/^_+/, '').squish
    end
  end

  protected

  def format_name
    Feature.format_name(name) if name.present?
  end

end

# == Schema Information
# Schema version: 20140616040112
#
# Table name: features
#
#  id          :integer          not null, primary key
#  name        :string(255)      indexed
#  enabled     :boolean          default(FALSE)
#  description :text
#  rules       :integer          default(0), not null
#  production  :boolean          default(FALSE)
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_features_on_name  (name) UNIQUE
#
