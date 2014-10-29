require 'rails_helper'

RSpec.describe TwitterAccount, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

# == Schema Information
# Schema version: 20141029053516
#
# Table name: twitter_accounts
#
#  id          :integer          not null, primary key
#  user_id     :integer
#  screen_name :string(255)
#  data        :json
#  created_at  :datetime
#  updated_at  :datetime
#
