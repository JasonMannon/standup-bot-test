class User < ActiveRecord::Base
  has_many :standups
  belongs_to :channel

  validates :slack_id, uniqueness: true

  class << self
    def registered?(id)
      User.where(slack_id: id).exists?
    end
  end
end
