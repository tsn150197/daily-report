FactoryBot.define do
  factory :trainer, class: Trainer do
    email {"trainer@email.com"}
    password {"123123"}
  end
end
