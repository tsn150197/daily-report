RSpec.describe Report, type: :model do
  let(:report) {FactoryBot.create :report}
  subject {FactoryBot.create :report}

  context "associations" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to have_many(:comments).dependent(:destroy)}
  end

  context "validates" do
    it {is_expected.to validate_presence_of :title}
    it {is_expected.to validate_uniqueness_of(:title)}
    it {is_expected.to validate_presence_of :date}
  end

  describe ".where_title" do
    it "return list reports of result that match" do
      expect(Report.where_title "t").to include(report)
    end
  end

  describe ".where_from_date" do
    it "return list reports of result that match" do
      expect(Report.where_from_date "1990-02-02").to include(report)
    end
  end

  describe ".where_to_date" do
    it "return list reports of result that match" do
      expect(Report.where_to_date "2020-02-02").to include(report)
    end
  end
end
