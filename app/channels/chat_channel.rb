class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_room_#{params['room_code']}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(data)
    room = Room.friendly.find(params['room_code'])
    persona = Persona.find_by(room_id: room.id, account_id: current_account.id)
    Post.create \
      room_id: room.id, persona_id: persona.id, content: data['content']
  end
end
