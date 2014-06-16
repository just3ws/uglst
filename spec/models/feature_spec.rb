# TODO: Add support to pass in the current_user

RSpec.describe Feature, :type => :model do
  it { should ensure_length_of(:description ).is_at_most(1024) }
  it { should allow_value(nil).for(:description) }
  it { should allow_value('').for(:description) }

  it { should ensure_length_of(:name).is_at_most(32).is_at_least(1) }

  it 'formats the name' do
    name = '\' this   is a -- really -- bad name for   a feature!\''
    expect(Feature.format_name(name)).to eq('this_is_a_really_bad_name_for_a_feature')
  end

  context '.ok?' do
    it 'will not be okay if the feature is not defined' do
      expect(Feature.ok?('non-existant')).to be(false)
    end

    it 'will try to look up a feature if called as a method' do
      feature_name = 'my new feature'
      expect(Feature.ok!(feature_name, true)).to be(true)

      expect(Feature.my_new_feature?).to be(true)
    end
  end

  context '.ok!' do

    it 'creates the feature and returns the ruling' do
      feature_name = 'my new feature'
      expect(Feature.ok!(feature_name, true)).to be(true)
      expect(Feature.ok?(feature_name)).to be(true)

      expect(Feature.ok!(feature_name, false)).to be(false)
      expect(Feature.ok?(feature_name)).to be(false)
    end
  end
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
