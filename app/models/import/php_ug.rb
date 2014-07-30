class Import::PhpUg < ActiveRecord::Base

  URL ||= 'http://php.ug/api/rest/listtype.json/1'

  def self.fetch_and_store
    response = RestClient.get(URL, accept: :json)
    fail "Could not fetch from #{URL} because received HTTP status #{response.code}" unless response.code == 200
    data = MultiJson.load(response)['groups']

    data.each do |user_group|
    Import::PhpUg.find_or_create_by(php_ug_id: Integer(user_group['id'])) do |m|
      m.php_ug_data = MultiJson.dump(user_group)
    end
    end
  end
end
