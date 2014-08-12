class Import::PhpUg < ActiveRecord::Base
  URL ||= 'http://php.ug/api/rest/listtype.json/1'

  def self.fetch
    response = RestClient.get(URL, accept: :json)

    unless 200 == response.code
      fail "Could not fetch from #{URL} because received HTTP status #{response.code}"
    end

    MultiJson.load(response)['groups']
  end

  def self.store(user_groups)
    user_groups.each do |user_group|
      Import::PhpUg.find_or_create_by(php_ug_id: Integer(user_group['id'])) do |m|
        m.php_ug_data = MultiJson.dump(user_group)
      end
    end
  end
end

# == Schema Information
# Schema version: 20140730061759
#
# Table name: import_php_ugs
#
#  id          :integer          not null, primary key
#  php_ug_id   :integer
#  php_ug_data :json
#  created_at  :datetime
#  updated_at  :datetime
#
