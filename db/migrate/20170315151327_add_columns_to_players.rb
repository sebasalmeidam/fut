class AddColumnsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :buy, :string
    add_column :players, :sell, :string
    add_column :players, :mail, :boolean
  end
end
