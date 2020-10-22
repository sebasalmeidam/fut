class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :player, index: true, foreign_key: true
      t.integer :sell_in
      t.float :afterTax
      t.float :pMargin
      t.float :nMargin
      t.float :buy_in

      t.timestamps null: false
    end
  end
end
