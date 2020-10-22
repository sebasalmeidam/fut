class SalesController < ApplicationController

	before_action :find_player

	def new
		@sale = Sale.new
		
		respond_to do |format|
	    format.html
    	format.js
  	end
	end

	def create
		@sale = Sale.new(sales_params)

  	if @sale.save
			@player.buy = @sale.buy_in.to_i
			@player.save
  		
  		respond_to do |format|
  			
  			format.js { flash.now[:notice] = "El adjunto ha sido agregado correctamente." }
    	end
  	else
  		errors = []
  		@sale.errors.full_messages.each do |msg|
  			errors << msg
  		end
  		respond_to do |format|
      	format.js { flash.now[:notice] = "#{errors.to_sentence}." }
    	end
  	end
	end

	def destroy
		sale = Sale.find(params[:id])
		sale.destroy
		redirect_to player_path(@player)
	end

	private

		def sales_params
			params.require(:sale).permit(:player_id, :buy_in, :sell_in, :pMargin, :nMargin, :afterTax)
		end

		def find_player
			if params[:player_id]
				@player = Player.find(params[:player_id])
			end
		end

end
