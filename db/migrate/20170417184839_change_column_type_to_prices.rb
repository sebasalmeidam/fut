class ChangeColumnTypeToPrices < ActiveRecord::Migration
  def up
  	change_column :prices, :price, 'float USING CAST(price AS float)'
  end
  def down
  	change_column :prices, :price, :string
  end
end
