class Api::V1::PlayersController < ApiController
	before_action :authenticate_with_token!
	respond_to :json
	
	def index
		if Player.search(params)
			@players = current_user.players.search(params).order(:buyed, current: :desc)
			respond_with @players
		else
			@players = current_user.players.order(:buyed, current: :desc)
			respond_with @players
		end
	end

	def show
		@player = current_user.players.find(params[:id])
		@prices = @player.prices.order(updated_at: :desc)

		  require 'nokogiri'
      require 'open-uri'
      

      #encoded_url = CGI::escape(@player.url)
      
      doc = Nokogiri::HTML(open(@player.url))
      @prev = doc.css('#pslbin').text
      @price = @prev.to_i * 1000
      @player.current = @price
      @player.prices.build(price: @price)
      @player.save
		
		@response = {player: @player, prices: @prices}
		respond_with @response

	end

	def create
    @player = Player.new(player_params)
    if @player.save
      render json: @player, status: 201, location: [:api, @player]
    else
      render json: { errors: @player.errors }, status: 422
    end
  end

  def update
  	player = current_user.players.find(params[:id])

  	if player.update(player_update_params)
	    render json: {flash: 'El jugadorJugador ha sido actualizado'}, status: 200, location: [:api, player]
	  else
	    render json: { errors: player.errors }, status: 422

	  end
	end

	def destroy
	  player = current_user.players.find(params[:id])
	  player.destroy
	  head 204
	end

	def api_edit_mail
		player = current_user.players.find(params[:id])
		if player.mail
			player.mail = false
		else
			player.mail = true
		end
		player.save
		response = {flash: "Mail actualizado correctamente", status: 200 }
		respond_with response
	end

	def api_edit_buyed
		player = current_user.players.find(params[:id])
		if player.buyed
			player.buyed = false
		else
			player.buyed = true
		end
		player.save
		response = {flash: 'Compra actualizada correctamente', status: 200 }
		respond_with response
	end

  private

    def player_params
      params.permit(:player, :url, :buy, :sell, :mail, :user_id, :buyed, :tp)
    end

    def player_update_params
      params.permit(:player, :buy, :sell)
    end

end