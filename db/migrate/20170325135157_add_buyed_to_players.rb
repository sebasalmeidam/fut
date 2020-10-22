class AddBuyedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :buyed, :boolean, default: false
  end
end
