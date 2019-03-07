class Persona < ApplicationRecord
  # association
  belongs_to :account
  belongs_to :room

  # validation
  validates :name,
    presence: true,
    length: { maximum: 255 }
end
