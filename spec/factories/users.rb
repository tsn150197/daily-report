FactoryBot.define do
  factory :user, class: User do
    email {"user@email.com"}
    password {"123123"}
  end
end
