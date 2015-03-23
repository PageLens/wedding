class Reservation < ActiveRecord::Base
  extend FriendlyId

  has_many :guests, dependent: :destroy
  accepts_nested_attributes_for :guests, allow_destroy: true

  friendly_id :name, use: :slugged

  validates :guests, presence: true
  validate :ensure_at_least_first_guest_has_email

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

end
