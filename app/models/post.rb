class Post < ApplicationRecord
  # association
  belongs_to :room
  belongs_to :persona

  # validation
  validates :content, presence: true

  after_create_commit { BroadcastNewPostJob.perform_later self }
end
