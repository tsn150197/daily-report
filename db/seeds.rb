Admin.create! email: "zxc@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now, type: "Admin"
User.first.create_user_profile name: "Z X C", gender: 1
Trainer.create! email: "abc1997@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now, type: "Trainer"
Trainer.first.create_user_profile name: "Trainer Test", gender: 1
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
