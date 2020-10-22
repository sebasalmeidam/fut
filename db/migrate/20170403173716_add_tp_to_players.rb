class AddTpToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :tp, :string
  end
end
