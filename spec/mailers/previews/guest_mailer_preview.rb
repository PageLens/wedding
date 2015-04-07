# Preview all emails at http://localhost:3000/rails/mailers/guest_mailer
class GuestMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/guest_mailer/confirmation
  def confirmation
    GuestMailer.confirmation(Guest.first || FactoryGirl.create(:guest))
  end

end
