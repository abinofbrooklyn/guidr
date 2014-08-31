class GuidrMessage
  Pusher.app_id = ENV['Pusher.app_id']
  Pusher.key = ENV['Pusher.key']
  Pusher.secret = ENV['Pusher.secret']

  def initialize(message)
    @message = message
  end

  def send
    data = {
      id: "#{@message.id}",
      user: "#{@message.user.email}",
      body: "#{@message.body}",
      time: "#{@message.created_at.strftime("%I:%M %p")}"
    }

    Pusher["guidr_channel_#{@message.conversation_id}"].trigger(
      "new_message",
      data
    )

  end
end
