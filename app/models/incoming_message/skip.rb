require_relative 'compound'

class IncomingMessage
  class Skip < Compound

    def execute
      super

      if @standup.active?
        @standup.skip!

        @client.message channel: @message['channel'], text: "I'll get back to you at the end of standup."
      end
    end

    def validate!
      super
    end

  end
end
