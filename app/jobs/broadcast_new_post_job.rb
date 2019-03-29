class BroadcastNewPostJob < ApplicationJob
  queue_as :default

  def perform(data)
    ActionCable.server.broadcast "chat_channel_room_#{data.room.code}",
      message: render_post(data)
  end

  private

  def render_post(new_post)
    ApplicationController.renderer.render partial: 'posts/post',
      locals: { post: new_post }
  end
end
