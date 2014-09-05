module Import
  module PhpUg
    class ExtractJob
      include Sidekiq::Worker

      def perform
        user_groups_data.each do |user_group_data|
          remote_id = user_group_data['id']
          if process?(remote_id, user_group_data)
            seconds_from_now = Random.rand((0..3600)).seconds.from_now
            Import::PhpUg::TransformJob.perform_in(seconds_from_now, remote_id, user_group_data)
          end
        end
      end

      def process?(remote_id, user_group_data)
        # If the data is already present in our system then don't re-process.
        return false if Import::Data::PhpUg.where(id: remote_id).exists?

        Import::Data::PhpUg.create!(
                id: remote_id,
                data: user_group_data,
                state: 'extract'
            )

        true
      end

      def api_url
        'http://php.ug/api/rest/listtype.json/1'
      end

      def user_groups_data
        response = RestClient.get(api_url, accept: :json)

        unless 200 == response.code
          fail "Could not fetch from #{api_url} because received HTTP status #{response.code}"
        end

        MultiJson.load(response)['groups']
      end
    end
  end
end
# {
#   id: 195,
#   name: "Davao PHP Developers Community",
#   shortname: "DPHPD",
#   url: "https://www.facebook.com/groups/1471544429755363/",
#   icalendar_url: "",
#   latitude: 7.190708,
#   longitude: 125.455341,
#   state: 1,
#   contacts: [
#     {
#       url: "https://www.facebook.com/1471544429755363",
#       name: "1471544429755363",
#       type: "Facebook",
#       cssClass: "fa-facebook fa"
#     },
#     {
#       url: "http://twitter.com/dphpd",
#       name: "dphpd",
#       type: "Twitter",
#       cssClass: "fa-twitter fa"
#     }
#   ],
#   ugtype: { id: 1, name: "PHP-Usergroups", description: "PHP-Usergroups" },
#   country: "PH"
# }
