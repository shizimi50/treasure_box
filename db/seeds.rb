# メインのサンプルユーザーを1人作成する
User.create!(name:  "test User",
    email: "test@railsstudy.com",
    password:              "foobar",
    password_confirmation: "foobar",
    admin:     true,
    activated: true,
    activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
10.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railsstudy.com"
password = "password"
User.create!(name:  name,
     email: email,
     password:              password,
     password_confirmation: password,
     activated: true,
     activated_at: Time.zone.now)
end