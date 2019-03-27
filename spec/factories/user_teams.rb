FactoryBot.define do
  factory :user_team, class: UserTeam do
    user
    team
  end
end
