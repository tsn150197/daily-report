class User < ApplicationRecord
  TYPES = %w(Admin Trainer Trainee).freeze
  has_many :comments, dependent: :destroy
  has_many :teams, through: :user_team
  has_many :reports, dependent: :destroy
  has_many :user_teams
  has_one :user_profile
end
