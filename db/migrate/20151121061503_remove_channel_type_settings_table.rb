class RemoveChannelTypeSettingsTable < ActiveRecord::Migration
  def change
    remove_column :settings, :channel_type
  end
end
