class UserMailer < ApplicationMailer
	default from: "email@gmail.com"
	

	def buy_players(player)
		@user = player.user
		@player = player
		@price = @player.prices.last
		mail(to: @user.email, subject: "Hora de comprar a #{@player.player}")
	end

	def sell_players(player)
		@user = player.user
		@player = player
		@price = @player.prices.last
		mail(to: @user.email, subject: "Hora de vender a #{@player.player}")
	end

	def min_trend(player)
		@user = player.user
		@player = player
		mail(to: @user.email, subject: "Tendencia a la baja de #{@player.player}")
	end

	def up_trend(player)
		@user = player.user
		@player = player
		mail(to: @user.email, subject: "Tendencia de subida de #{@player.player}")
	end

end
