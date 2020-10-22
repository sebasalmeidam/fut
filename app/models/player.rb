class Player < ActiveRecord::Base
	has_many :prices, dependent: :destroy
  has_many :sales, dependent: :destroy
	belongs_to :user

	scope :filter_by_player, lambda { |keyword|
    where("lower(player) LIKE ?", "%#{keyword.downcase}%" ) 
  }

  def self.search(params = {})
    players = params[:player_ids].present? ? Player.find(params[:player_ids]) : Player.all

    players = players.filter_by_player(params[:keyword]) if params[:keyword]
    
    players
  end

  validates :url, :user_id, presence: true

  validates :buy, numericality: {only_integer: true, greater_than_or_equal_to: 0, message: "El valor ingresado debe ser un número entero."}

  validates :sell, numericality: {only_integer: true, greater_than_or_equal_to: 0, message: "El valor ingresado debe ser un número entero."}


end
