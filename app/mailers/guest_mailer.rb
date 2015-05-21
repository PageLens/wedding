class GuestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.guest_mailer.confirmation.subject
  #
  def confirmation(guest)
    @guest = guest
    case guest.state
    when 'attend_both'
      attachments['LizaJerryWedding.ics'] = {content: Event.wedding.to_ical}
    when 'ceremony_only'
      attachments['LizaJerryWedding.ics'] = {content: Event.ceremony.to_ical}
    end
    mail to: guest.email
  end
end
