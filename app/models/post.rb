class Post < ApplicationRecord
  # association
  belongs_to :room
  belongs_to :persona

  # validation
  validates :content, presence: true
end
