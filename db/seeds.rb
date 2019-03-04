Admin.create! email: "admin@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now
User.first.create_user_profile name: "Admin TEST", gender: 1
Trainer.create! email: "trainer@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now
Trainer.first.create_user_profile name: "TraineR TEST", gender: 1,
  birthday: "22-09-2015", address: "Hiệp Hòa - Bắc Giang", phone: "0963097932"
Trainee.create! email: "trainee@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now
Trainee.first.create_user_profile name: "TraineE TEST", gender: 1
Team.create! name: "ruby"
Team.create! name: "php"
Team.create! name: "android"
Team.create! name: "java"
(1...50).each do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@test.com"
  password = "123123"
  user = Trainer.create! email: email, password: password,
    password_confirmation: password, activated: true,
      activated_at: Time.zone.now
  user.create_user_profile name: name
end
(50...100).each do |n|
  name = Faker::Name.name
  email = "test-#{n+1}@test.com"
  password = "123123"
  user = Trainee.create! email: email, password: password,
    password_confirmation: password, activated: true,
      activated_at: Time.zone.now
  user.create_user_profile name: name
end

Trainer.first.user_team Team.find_by(name: "ruby")
Trainee.first.user_team Team.find_by(name: "ruby")
(1..50).each do |n|
  Trainee.first.reports.create title: "Team ruby test #{n}", date: "2019-02-28",
    content: "<h3>TEST</h3>"
end
