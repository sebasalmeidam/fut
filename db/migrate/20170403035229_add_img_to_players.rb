class AddImgToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :img, :string
  end
end
