FactoryBot.define do
  factory :comment, class: Comment do
    user
    report
    content {"test comment"}
  end
end
