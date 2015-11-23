class AddShoutoutsToStandups < ActiveRecord::Migration
  def change
    add_column :standups, :shoutouts, :text
  end
end
