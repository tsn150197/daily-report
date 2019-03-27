RSpec.describe UserProfile, type: :model do
  subject {FactoryBot.create :user_profile}

  context "associations" do
    it {is_expected.to belong_to :user}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :name}
    it {is_expected.to validate_length_of(:name).is_at_most 50}
  end
end
