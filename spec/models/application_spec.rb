RSpec.describe ApplicationRecord do
  let(:user) {FactoryBot.create :report}
  describe ".human_enum_name" do
    it "return i18n enum" do
      expect(Report.human_enum_name :status, :rejected).to eq("Rejected")
    end
  end
end
