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
