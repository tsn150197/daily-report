FactoryBot.define do
  factory :report, class: Report do
    user
    title {"title"}
    content {"content"}
    date {"1997-02-02"}
  end
end
