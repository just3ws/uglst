describe User, :pending do
  # it { should validate_presence_of :username }

  # it 'creates a slug from the username' do
  # username = 'this.name'
  # User.create!(username: username, password: 'password', password_confirmation: 'password', email: Faker::Internet.email).slug.should == 'this-name'
  # User.where(slug: 'this-name').should_not be_nil
  # end

  # it 'can register a user-group' do
  # username = 'this.name'
  # user = User.create!(username: username, password: 'password', password_confirmation: 'password', email: Faker::Internet.email)
  # user.slug.should == 'this-name'
  # user.user_groups_registered.build(name: 'my user group')
  # user.save!
  # UserGroup.count.should == 1
  # user.interests << 'ruby'
  # user.save!
  # user.interests.should == ['ruby']
  # end
end

# == Schema Information
# Schema version: 20140530064405
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  email                  :string(255)      default(""), not null, indexed
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)      indexed
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  username               :string(255)      indexed
#  slug                   :string(255)      indexed
#  twitter                :string(255)
#  homepage               :string(255)
#  first_name             :string(255)
#  last_name              :string(255)
#  address                :string(255)
#  formatted_address      :string(255)
#  city                   :string(255)
#  state_province         :string(255)
#  country                :string(255)
#  birthday               :text
#  ethnicity              :text
#  gender                 :text
#  parental_status        :text
#  race                   :text
#  relationship_status    :text
#  religious_affiliation  :text
#  sexual_orientation     :text
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  interests              :string(255)      is an Array
#  bio                    :text
#  latitude               :float            indexed => [longitude]
#  longitude              :float            indexed => [latitude]
#  admin                  :boolean          default(FALSE)
#  created_at             :datetime
#  updated_at             :datetime
#
# Indexes
#
#  index_users_on_email                   (email) UNIQUE
#  index_users_on_latitude_and_longitude  (latitude,longitude)
#  index_users_on_reset_password_token    (reset_password_token) UNIQUE
#  index_users_on_slug                    (slug) UNIQUE
#  index_users_on_username                (username) UNIQUE
#
