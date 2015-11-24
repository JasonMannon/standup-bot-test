require 'rspec/mocks'

class SlackMock
  extend RSpec::Mocks::ExampleMethods

  def self.client_for(users)
    client = Slack::RealTime::Client.new

    groups = [{ name: setting.name, members: users }.with_indifferent_access]

    slack_users = users.map do |user|
      { id: user.slack_id, profile: { image_72: Faker::Avatar.image } }.with_indifferent_access
    end

    allow(client).to receive(:start!)
    allow(client).to receive(:stop!)
    allow(client).to receive(:message)
    allow(client).to receive(:users).and_return(slack_users)
    allow(client).to receive(:groups).and_return(groups)

    client
  end

  def self.setting
    Setting.first || FactoryGirl.create(:setting)
  end
end
