class AddTrackToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :track, :boolean, default: false
  end
end
