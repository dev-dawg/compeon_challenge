class MessageHandler
# SMS can only be a maximum of 160 characters.
# If the user wants to send a message bigger than that, we need to break it up.
# We want a multi-part message to have this suffix added to each message:
# " - Part X of Y"

# You need to fix this method, currently it will crash with > 160 char messages.

# I made the assumption, that " - Part X of Y" is something the SMS client needs to put the message back together, so it is not included in the character limit.
  def self.send_sms_message(text, to, from)
    messages = text.scan(/.{1,160}/)
    messages_new = []

    if messages.length > 1
      messages.each_with_index do |m, i|
        messages_new.push("#{m}#{' - Part '}#{i + 1}#{' of '}#{messages.length}")
      end
    else
      messages_new.push(messages[0])
    end

    messages_new.each do |message|
      self.deliver_message_via_carrier(message, to, from)
    end
  end

  private
  # This method actually sends the message via a SMS carrier
  # This method works, __you don't change it__,
  def self.deliver_message_via_carrier(text, to, from)
    SMS_CARRIER.deliver_message(text, to, from)
  end
end
