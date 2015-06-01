FactoryGirl.define do
  factory :participant, class: User do
    username 'participant'
    email 'participant@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :administrator, class: User do
    username 'administrator'
    email 'administrator@example.com'
    password 'password'
    password_confirmation 'password'
    admin true
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  slug                   :string
#  username               :string
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#
