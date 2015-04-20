class ApplicationMailer < ActionMailer::Base
  include Roadie::Rails::Automatic

  # default from: "info@lizaandjerry.com"
  default from: "lizaandjerry@gmail.com"
  layout 'mailer'
end
