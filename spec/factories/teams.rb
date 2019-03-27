require 'faker'

FactoryBot.define do
  factory :team, class: Team do
    name {Faker::Team.name}
  end
end
