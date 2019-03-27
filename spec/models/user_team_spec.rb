RSpec.describe UserProfile, type: :model do
  subject {FactoryBot.create :user_team}

  context "associations" do
    it {is_expected.to belong_to :user}
    it {is_expected.to belong_to :team}
  end
end
