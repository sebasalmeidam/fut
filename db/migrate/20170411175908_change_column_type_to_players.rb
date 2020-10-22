class ChangeColumnTypeToPlayers < ActiveRecord::Migration
  def up
  	change_column :players, :current, 'integer USING CAST(current AS integer)'
  	change_column :players, :buy, 'integer USING CAST(buy AS integer)'
  	change_column :players, :sell, 'integer USING CAST(sell AS integer)'
  end
  def down
  	change_column :players, :current, :string
  	change_column :players, :buy, :string
  	change_column :players, :sell, :string
  end
end
