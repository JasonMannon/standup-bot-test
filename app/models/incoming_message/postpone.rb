require_relative 'simple'

class IncomingMessage
  class Postpone < Simple
    def execute
      super

      @standup.skip!

      @client.message(
        channel: @message['channel'],
        text: "I'll get back to you at the end of standup."
      )
    end

    def validate!
      if !@standup.active?
        raise InvalidCommand.new("You can only skip the standup when asked.")
      end

      super
    end
  end
end
