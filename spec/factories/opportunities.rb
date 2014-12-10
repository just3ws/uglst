FactoryGirl.define do
  factory :opportunity do
    name "MyString"
    description "MyText"
  end
end

# == Schema Information
#
# Table name: opportunities
#
#  id          :uuid             not null, primary key
#  name        :string
#  description :text
#  state       :integer          default("0"), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
