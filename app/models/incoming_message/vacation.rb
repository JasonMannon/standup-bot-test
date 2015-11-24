require_relative 'compound'

class IncomingMessage
  class Vacation < Compound
    def execute
      super

      @standup.vacation!

      @client.message channel: @message['channel'], text: "<@#{reffered_user.slack_id}> has been put on vacation."
    end

    def validate!
      super
    end
  end
end

