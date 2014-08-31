module Importx
end

# class Import::PhpUg < ActiveRecord::Base

# enum state: %i(ready imported)

# def self.remote_source
# Source.find_by(slug: 'php-usergroup')
# end

# URL ||= 'http://php.ug/api/rest/listtype.json/1'

# def self.fetch
# response = RestClient.get(URL, accept: :json)

# unless 200 == response.code
# fail "Could not fetch from #{URL} because received HTTP status #{response.code}"
# end

# MultiJson.load(response)['groups']
# end

# def self.store(user_groups)
# user_groups.each do |user_group|
# Import::PhpUg.find_or_create_by(php_ug_id: Integer(user_group['id'])) do |m|
# m.php_ug_data = MultiJson.dump(user_group)
# end
# end
# end

# def self.untransformed
# Import::PhpUg.ready.find_each(batch_size: 20) do |import|
## create a new SourceHistory record
## create new User-Group
# data = import.php_ug_data

# geo = Geocoder.search("#{data['latitude']},#{data['longitude']}").try(:first)
# next unless geo
# geo_attrs = { city: geo.city, country: geo.country, state_province: geo.state, address: "#{geo.city}, #{geo.state}, #{geo.country}" }

# exit
# end
# end
# end

## == Schema Information
## Schema version: 20140804214014
##
## Table name: import_php_ugs
##
##  id          :integer          not null, primary key
##  php_ug_id   :integer
##  php_ug_data :json
##  created_at  :datetime
##  updated_at  :datetime
##
