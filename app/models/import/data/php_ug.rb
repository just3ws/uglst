module Import
  module Data
    class PhpUg < ActiveRecord::Base
    end
  end
end

# == Schema Information
#
# Table name: import_data_php_ugs
#
#  id         :integer          not null, primary key
#  data       :json
#  state      :string
#  created_at :datetime
#  updated_at :datetime
#
