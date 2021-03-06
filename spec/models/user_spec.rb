# frozen_string_literal: true
RSpec.describe User, type: :model do
  it 'creates a slug from the username' do
    allow_any_instance_of(User).to receive(:send_welcome_email)

    username = 'this.name'
    expect(User.create!(
      username: username,
      password: 'password',
      password_confirmation: 'password',
      email: FFaker::Internet.email
    ).slug).to eq('this-name')
    expect(User.friendly.find('this-name')).to_not be_nil
  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :uuid             not null, primary key
#  admin                  :boolean          default(FALSE)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  slug                   :string(255)
#  username               :string(255)
#  email_opt_in           :boolean          default(FALSE)
#  send_stickers          :boolean
#  stickers_sent_on       :date
#  created_at             :datetime
#  updated_at             :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#
