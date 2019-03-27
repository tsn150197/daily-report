FactoryBot.define do
  factory :trainee, class: Trainee do
    email {"trainee@email.com"}
    password {"123123"}
  end
end
