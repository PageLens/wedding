class ApplicationMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  default from: "info@lizaandjerry.com"
  layout 'mailer'
end
