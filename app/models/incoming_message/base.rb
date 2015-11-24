class IncomingMessage
  class Base
    class InvalidCommand < StandardError; end

    def initialize(client, message, standup)
      @client  = client
      @message = message
      @standup = standup
    end

    def execute
      self.validate!
    end

    # @return [Boolean]
    # @raise [InvalidCommand]
    def validate!
      true
    end

    def channel
      @standup.channel
    end

    def user
      raise 'Missing implementation #user'
    end
  end
end
