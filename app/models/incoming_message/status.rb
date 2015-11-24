require_relative 'simple'

class IncomingMessage
  class Status < Simple
    def execute
      super

      message = @standup.channel.today_standups.map do |standup|
        "#{standup.status}\n"
      end

      @client.message(
        channel: @message['channel'],
        text: message.join
      )
    end
  end
end
