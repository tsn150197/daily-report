FactoryBot.define do
  factory :admin, class: Admin do
    email {"admin@email.com"}
    password {"123123"}
  end
end
