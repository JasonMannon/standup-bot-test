require_relative 'compound'

class IncomingMessage
  class NotAvailable < Compound
    def execute
      super

      if @standup.active?
        @standup.not_available!

        @client.message(
          channel: @message['channel'],
          text: "<@#{reffered_user.slack_id}> is not available."
        )
      end
    end

    def validate!
      super
    end
  end
end
