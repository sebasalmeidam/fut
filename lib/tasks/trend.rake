desc 'detect trends and update buy and sell prices'
task trend: :environment do
	
	def last_hours_projection(player, horas, tiempo)
		require 'linefit'
    line = LineFit.new
    x_data = player.prices.where(created_at: (Time.now - horas.hours)..(Time.now)).where('price > ?', 0).collect(&:created_at).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
    y_data = player.prices.collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}.last(x_data.count)
    x_data.count > 0
  	line.setData(x_data,y_data) 
  	newx_data = (player.prices.last.created_at + tiempo.minutes).to_f
  	begin
      line.forecast(newx_data).to_i if !line.forecast(newx_data).nil?
    rescue NoMethodError
      player.current.to_i
    end
  end


	Player.all.each do |player|
		projections = []
		puts "correct PLAYER #{player.player}"
		intervals = [1,3,6,9,12,15,18,21,24,48,72,96,120,144,168]
		intervals.each do |i|
			
			proj = last_hours_projection(player, i, 60)
			projections << proj
			
		end

		less_than_current 	 = projections.select{|e| e.to_i < player.current}
		greater_than_current = projections.select{|e| e.to_i > player.current}

		puts "menores: #{less_than_current.count}"
		puts "mayores: #{greater_than_current.count}"


		if less_than_current.count != greater_than_current.count
			require 'descriptive_statistics'
			if less_than_current.count > greater_than_current.count
				median = less_than_current.median.to_i
				if median <= (player.current * 0.87)
					player.sell = (player.current + 100).to_i
					player.buy = (player.current * 0.87).to_i
					player.save
					UserMailer.min_trend(player).deliver_now
				end
			elsif greater_than_current.count > less_than_current.count
				median = greater_than_current.median.to_i
				if median >= (player.current / 0.87)
					player.buy = (player.current + 100).to_i
					player.sell = (player.current / 0.87).to_i
					player.save
					UserMailer.up_trend(player).deliver_now
				end
			end
		end

		if player.buy.to_i > (player.current * 1.20).to_i
			player.buy = (player.current - 100).to_i
			player.save
		end
		
		if player.sell.to_i > (player.current * 1.20).to_i
			player.sell = (player.current / 0.87).to_i
			player.save
		end

	end
end