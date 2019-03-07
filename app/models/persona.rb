class Persona < ApplicationRecord
  # association
  belongs_to :account
  belongs_to :room

  # Active Strage
  has_one_attached :icon

  # validation
  validates :name,
    presence: true,
    length: { maximum: 255 }
end
