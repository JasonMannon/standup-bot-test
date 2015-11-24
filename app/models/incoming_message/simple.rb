require_relative 'base'

class IncomingMessage
  class Simple < Base
    def user
      User.where(slack_id: @message['user']).first!
    end
  end
end
