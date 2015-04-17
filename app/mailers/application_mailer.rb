class ApplicationMailer < ActionMailer::Base
  # include Roadie::Rails::Automatic

  default from: "jerryluk@gmail.com"
  layout 'mailer'
end
