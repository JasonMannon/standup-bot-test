require_relative 'base'

class IncomingMessage
  class Compound < Base
    def initialize(client, message, standup)
      super(client, message, standup)

      @standup = reffered_user.standups.today.first!
    end

    def user
      User.where(slack_id: @message['user']).first
    end

    def reffered_user
      User.where(slack_id: @message['text'][/\<.*?\>/].gsub(/[<>@]/, '')).first
    end

    def valid?
      if reffered_user.blank?
        raise InvalidCommand.new("<@#{user.slack_id}> Given user does not exist in this channel.")
      end

      super
    end
  end
end
