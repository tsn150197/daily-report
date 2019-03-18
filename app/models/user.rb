class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  TYPES = %w(Admin Trainer Trainee).freeze
  attr_reader :remember_token, :reset_token
  has_many :comments, dependent: :destroy
  has_many :user_teams
  has_many :teams, through: :user_teams
  has_many :reports, dependent: :destroy
  has_one :user_profile
  validates :email, presence: true, length: {maximum: Settings.email_maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: Settings.password_minimum},
    allow_nil: true
  before_save :downcase_email
  has_secure_password
  scope :verified_user, ->(param1, param2){find_by id: [param1, param2]}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def user_team team
    teams << team
  end

  def remember
    @remember_token = User.new_token
    update remember_digest: User.digest(@remember_token)
  end

  def forget
    update remember_digest: nil
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"

    return false unless digest
    BCrypt::Password.new(digest).is_password? token
  end

  def current_user? user
    self == user
  end

  def create_reset_digest
    @reset_token = User.new_token
    update reset_digest: User.digest(@reset_token), reset_sent_at: Time.zone.now
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < Settings.expired_time_reset_password.hours.ago
  end

  private

  def downcase_email
    email.downcase!
  end
end
