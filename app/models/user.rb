class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  TYPES = %w(Admin Trainer Trainee).freeze
  has_many :comments, dependent: :destroy
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :reports, dependent: :destroy
  has_one :user_profile
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.password_minimum},
    allow_nil: true
  has_secure_password

  def user_team team
    teams << team
  end
end
