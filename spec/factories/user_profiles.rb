require 'faker'

FactoryBot.define do
  factory :user_profile, class: UserProfile do
    user
    name {Faker::Name.name}
  end
end
