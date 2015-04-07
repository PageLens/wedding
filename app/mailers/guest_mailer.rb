class GuestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.guest_mailer.confirmation.subject
  #
  def confirmation(guest)
    @guest = guest
    attachments['LizaJerryWedding.ics'] = {
      content: Event.wedding.to_ical
    }
    mail to: guest.email
  end
end
