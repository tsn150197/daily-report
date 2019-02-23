Admin.create! email: "famaxlevel1997@gmail.com",
  password: "123123", password_confirmation: "123123",
    activated: true, activated_at: Time.zone.now, type: "Admin"
User.first.create_user_profile name: "Nguyen Van Tuan",
  avatar_url: "http://icons.iconarchive.com/icons/hopstarter/halloween-avatar/256/Dave-icon.png",
    gender: 1
