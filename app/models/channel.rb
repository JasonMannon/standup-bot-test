class Channel < ActiveRecord::Base
  has_many :users
  has_many :standups, through: :users

  def start_today_standup!
    self.transaction do
      self.users.where(bot: false).each_with_index do |user, index|
        standup = Standup.create_if_needed(user.id, self.id)

        standup.order = index + 1

        standup.save
      end
    end
  end

  def today_standups
    self.standups.today
  end

  def pending_standups
    today_standups.pending.sorted
  end

  def current_standup
    self.standups.today.in_progress.first
  end

  def complete?
    completed_today_standups = today_standups.completed

    (users.count - 1) == completed_today_standups.count
  end
end
