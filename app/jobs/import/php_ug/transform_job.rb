module Import
  module PhpUg
    class TransformJob
      include Sidekiq::Worker

      def perform(user_group_data)
        Rails.logger.ap(user_group_data, :info)
        Rails.logger.ap(enhance_geo(user_group_data), :info)
      end

      def enhance_geo(data)
        geo = Geocoder.search("#{data['latitude']},#{data['longitude']}").try(:first)
        return {} unless geo
        geo_attrs = {
          city: geo.city,
          country: geo.country,
          state_province: geo.state,
          address: "#{geo.city}, #{geo.state}, #{geo.country}"
        }
      end
    end
  end
end
