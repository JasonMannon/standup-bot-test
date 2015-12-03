module FetchBot
  class Start < Grape::API
    get :start do
      @settings = Setting.first
      client = Slack::RealTime::Client.new

      client.on :hello do
        standup_channel = client.channels.detect { |c| c['name'] == @settings.name }
        channel = Channel.where(name: standup_channel['name'], slack_id: standup_channel['id']).first_or_initialize

        # TODO we need to move all this logic to a separated class
        ActiveRecord::Base.transaction do
          channel.save!

          users  = client.users
          bot_id = users.find { |what| what['name'] == @settings.bot_name }['id']

          @settings.update_attributes(bot_id: bot_id)

          standup_channel['members'].each do |member|
            slack_user = users.select { |u| u['id'] == member }.first

            user = User.where(slack_id: slack_user['id']).first_or_initialize

            user.full_name = slack_user['profile']['real_name']
            user.nickname = slack_user['name'].capitalize
            user.avatar_url = slack_user['profile']['image_72']
            user.bot = (slack_user['id'] == @settings.bot_id)

            user.save!

            channel.users << user
          end
        end

        if channel.complete?
          client.message channel: standup_channel['id'], text: 'Today\'s standup is already completed.'
          client.stop!
        else
          client.message channel: standup_channel['id'], text: '@channel: The Captain is ready to serve! "-help" for commands.'
        end
      end

      client.on :message do |data|
        IncomingMessage.new(data, client).execute
      end

      client.start!
    end

  end
end
