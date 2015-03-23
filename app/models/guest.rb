class Guest < ActiveRecord::Base
  enum state: [:attend_both, :ceremony_only, :not_attend]
  auto_strip_attributes :name, :email, :dietary

  belongs_to :reservation

  validates :name, presence: true
  validates :email, uniqueness: true, allow_blank: true
  validates :state, presence: true
end
