class Persona < ApplicationRecord
  # association
  belongs_to :account
  belongs_to :room
  has_many :posts

  # Active Strage
  has_one_attached :icon

  # validation
  validates :name,
    presence: true,
    length: { maximum: 255 }

  # callback
  after_create :auto_accept # TEMP

  private

  def auto_accept
    AcceptNewPeronaJob.set(wait: 20.seconds).perform_later(self.id)
  end

end
