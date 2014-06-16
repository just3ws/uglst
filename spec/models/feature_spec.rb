require 'rails_helper'

RSpec.describe Feature, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
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
