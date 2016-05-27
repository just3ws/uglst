# frozen_string_literal: true
module Geocodable
  extend ActiveSupport::Concern

  included do
    before_validation :geocode, if: :address_changed?

    validates :address, presence: true
    validate :geocodable, if: proc { |ug| ug.address.present? }

    geocoded_by :address do |obj, results|
      geo = results.first
      if geo
        obj.formatted_address = geo.formatted_address

        obj.city = geo.city
        obj.state_province = geo.state
        obj.country = geo.country_code

        obj.latitude = geo.latitude
        obj.longitude = geo.longitude
      else
        obj.formatted_address = nil

        obj.city = nil
        obj.state_province = nil
        obj.country = nil

        obj.latitude = nil
        obj.longitude = nil
      end
    end
  end

  def geocodable
    errors.add(:address, 'Does not appear to be a valid address') if latitude.nil? || longitude.nil?
  end
end
