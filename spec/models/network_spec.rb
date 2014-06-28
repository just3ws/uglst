require 'rails_helper'

RSpec.describe Network, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
# Schema version: 20140628174646
#
# Table name: networks
#
#  id               :uuid             not null, primary key
#  registered_by_id :uuid
#  homepage         :string(255)
#  name             :text             indexed
#  slug             :string(255)
#  twitter          :string(255)
#  description      :text
#  logo             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#
# Indexes
#
#  index_networks_on_name  (name)
#
