require_relative 'simple'

class IncomingMessage
  class Quit < Simple
    def execute
      super

      @client.message(
        channel: @message['channel'],
        text: I18n.t('activerecord.models.incoming_message.quit')
      )

      @client.stop!
    end
  end
end
