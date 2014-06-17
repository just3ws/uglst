class Feature < ActiveRecord::Base
  include Bitfields
  # Required Roles
  # 01 0001 guest
  # 02 0010 registered
  # 04 0100 admin
  bitfield :rules, 1 => :guest, 2 => :registered, 4 => :admin

  validates_uniqueness_of :name
  validates_length_of :name, maximum: 32, allow_blank: false, minimum: 1
  validates_length_of :description, maximum: 1024, allow_blank: true

  before_validation :format_name

  class << self
    def ok?(feature_name)
      formatted_name = format_name(feature_name)
      Feature.where(name: formatted_name).select(:enabled).any? { |feature| feature.enabled? }
    end

    def ok!(feature_name, enabled = false, description = '')
      feature             = Feature.find_or_create_by(name: format_name(feature_name))
      feature.enabled     = !!enabled
      feature.description = description.to_s.squish!
      if feature.changed?
        feature.save!
        feature.reload
      end
      feature.enabled?
    end

    def format_name(feature_name)
      feature_name.to_s.underscore.gsub(/\s/, '_').gsub(/\W/, '').gsub(/_+/, '_').gsub(/^_+/, '').squish
    end

    def method_missing(m, *args, &block)
      if m =~ /\?$/
        feature_name = format_name(m.to_s)
        logger.warn "Adding `Feature.#{feature_name}?` via method_missing."
        eigenclass = class << self;
          self;
        end
        eigenclass.class_eval do
          define_method("#{feature_name}?") do
            logger.warn "`Feature.#{feature_name}?` added via method_missing."
            ok?(feature_name)
          end
        end
      end
      send(m, *args, &block)
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
