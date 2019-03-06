class Team < ApplicationRecord
  has_many :user_teams
  has_many :users, through: :user_teams
  has_many :trainees, class_name: Trainee.name, through: :user_teams,
    source: :user
end
