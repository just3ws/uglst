module Import
  module PhpUg
    module Enrich
      def description(data)
        description = data['ugtype'].try(:[], 'description')
        description = nil if description == data['name']
        {description: description}
      end

      def social(data, name)
        social = data['contacts'].select { |contact| contact['type'].downcase == name.downcase }.try(:first)
        return {} unless social
        {name.downcase.to_sym => social['name']}
      end

      def geo(data)
        geo = Geocoder.search("#{data['latitude']},#{data['longitude']}").try(:first)
        return {} unless geo
        geo_attrs = {
            latitude: data['latitude'],
            longitude: data['longitude'],
            city: geo.city,
            country: geo.country,
            state_province: geo.state,
            address: "#{geo.city}, #{geo.state}, #{geo.country}"
        }
      end
    end

    class TransformJob
      include Sidekiq::Worker
      include Import::PhpUg::Enrich

      def perform(remote_id, user_group_data)
        Import::Data::PhpUg.find_by(id: remote_id).update_attribute(:state, 'transform')

        Geocoder.configure(always_raise: :all)

        ug = {}
        ug[:name] = user_group_data['name']
        ug[:topics] = %w(php)
        ug[:shortname] = user_group_data['shortname']
        ug[:homepage] = user_group_data['url']

        ug.merge!(geo(user_group_data))
        ug.merge!(description(user_group_data))
        %w(github twitter facebook meetup).each do |name|
          ug.merge!(social(user_group_data, name))
        end

        Import::PhpUg::LoadJob.perform_async(remote_id, ug)
      end
    end
  end
end
