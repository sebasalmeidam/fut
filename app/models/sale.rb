class Sale < ActiveRecord::Base
  belongs_to :player

  validates :player_id, :buy_in, :afterTax, :sell_in, :nMargin, :pMargin, presence: true
end
