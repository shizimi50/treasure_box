class ApplicationMailer < ActionMailer::Base
  default from: "noreply@example.com" # 送信元のアドレスを指定できる
  layout 'mailer'
end
