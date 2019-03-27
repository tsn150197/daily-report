RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  let(:team) {FactoryBot.create :team}
  subject {FactoryBot.create :user}

  context "associations" do
    it {is_expected.to have_many(:comments).dependent(:destroy)}
    it {is_expected.to have_many :user_teams}
    it {is_expected.to have_many(:teams).through(:user_teams)}
    it {is_expected.to have_many(:reports).dependent(:destroy)}
    it {is_expected.to have_one :user_profile}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :email}
    it {is_expected.to validate_length_of(:email).is_at_most 255}
    it {is_expected.to allow_value("email@gmail.com").for :email}
    it {is_expected.to validate_uniqueness_of(:email).case_insensitive}
    it {is_expected.to validate_length_of(:password).is_at_least(6)}
    it {is_expected.to have_secure_password()}
  end

  describe ".verified_user" do
    it "return a user of result that match" do
      expect(User.verified_user user, 5).to eq(user)
    end
  end

  describe ".digest" do
    it "return a digest of result that match" do
      expect(User.digest "123123").to eq(user.password)
    end
  end

  describe ".new_token" do
    it "return a token of result that match" do
      User.new_token
    end
  end

  describe "#user_team" do
    it "should do add team" do
      expect(user.user_team team).to eq(user.teams)
    end
  end

  describe "#remember" do
    it "update remember_digest" do
      expect(user.remember).to be true
    end
  end

  describe "#forget" do
    it "delete remember_digest" do
      expect(user.forget).to be true
    end
  end

  describe "#authenticated?" do
    it "authenticate remember" do
      user.remember
      expect(user.authenticated?(user.remember_token)).to be true
    end
  end
end
