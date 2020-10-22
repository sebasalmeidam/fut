class AddNotifToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :notif, :boolean, default: false
  end
end
