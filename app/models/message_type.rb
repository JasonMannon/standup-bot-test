class MessageType
  def initialize(message)
    @message = (message || '').downcase
  end

  def user_id
    @message[/\<.*?\>/].gsub(/[<>@]/, '').upcase
  end

  def yes?
    @message.include?('-yes')
  end

  def status?
    @message.include?('-status')
  end

  def vacation?
    @message.include?('-vacation: <@')
  end

  def skip?
    @message.include?('-skip: <@')
  end

  def postpone?
    @message == '-skip'
  end

  def edit?
    @message.include?('-edit:')
  end

  def delete?
    @message.include?('-delete:')
  end

  def quit?
    @message.include?('-quit-standup')
  end

  def help?
    @message.include?('-help')
  end

  def start?
    @message.include?('-start')
  end

  def not_available?
    @message.include?('-n/a:')
  end
end
