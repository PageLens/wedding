class Reservation < ActiveRecord::Base
  extend FriendlyId

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

  friendly_id :name, use: :slugged

  before_validation :remove_guests_on_update
  validates :guests, presence: true
  validate :ensure_at_least_first_guest_has_email
  after_create :deliver_mails

private

  def name
    guests.first.try(:name)
  end

  def ensure_at_least_first_guest_has_email
    first_guest = guests.first
    if first_guest
      first_guest.errors.add(:email, :blank) if first_guest.email.blank?
    end
  end

  def deliver_mails
    self.guests.each do |guest|
      GuestMailer.confirmation(guest).deliver_later if guest.email.present?
    end
  end

  def remove_guests_on_update
    if persisted?
      Guest.where(reservation_id: self.id).delete_all
    end
  end

end
