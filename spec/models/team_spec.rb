RSpec.describe Team, type: :model do
  subject {FactoryBot.create :team}

  context "associations" do
    it {is_expected.to have_many :user_teams}
    it {is_expected.to have_many(:users).through(:user_teams)}
    it {is_expected.to have_many(:trainees).class_name(Trainee.name)
                   .through(:user_teams)}
  end
end
