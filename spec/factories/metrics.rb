FactoryGirl.define do
  factory :metric do
    request_controller 'MyString'
    request_action 'MyString'
    request_ip 'MyString'
    request_xff 'MyString'
    request_requestor_id 'MyString'
    request_url 'MyString'
    request_method 'MyString'
    request_params ''
  end

end

# == Schema Information
#
# Table name: metrics
#
#  id                   :uuid             not null, primary key
#  session_id           :string
#  request_action       :string
#  request_controller   :string
#  request_ip           :string
#  request_method       :string
#  request_referrer     :string
#  request_requestor_ip :string
#  request_url          :string
#  request_user_agent   :string
#  request_xff          :string
#  user_id              :uuid
#  request_params       :json
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#
