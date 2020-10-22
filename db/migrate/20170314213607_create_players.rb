class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :player
      t.string :url

      t.timestamps null: false
    end
  end
end
