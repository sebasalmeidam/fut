desc 'update players buy sell and prices'
task update_values: :environment do
	Player.all.each do |player|
		player.buy = player.buy.to_i * 1000
		player.sell = player.sell.to_i * 1000
		player.save

		player.prices.each do |price|
			price.price = price.price.to_i * 1000
			price.save
		end
	end
end
