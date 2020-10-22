class AddCurrentToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :current, :string
  end
end
