RSpec.describe Comment, type: :model do
  subject {FactoryBot.build :comment}

  context "associations" do
    it {is_expected.to belong_to(:report)}
    it {is_expected.to belong_to(:user)}
  end
end
