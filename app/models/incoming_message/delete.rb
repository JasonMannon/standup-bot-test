require_relative 'simple'

class IncomingMessage
  class Delete < Simple
    def execute
      super

      @standup.delete_answer_for(@message['text'].split('').last.try(:to_i))

      @client.message(
        channel: @message['channel'],
        text: 'Answer deleted'
      )
    end

    def validate!
      if @standup.idle? || @standup.active?
        raise InvalidCommand.new("<@#{user.slack_id}> You can not delete an answer before your standup.")
      end

      super
    end
  end
end
