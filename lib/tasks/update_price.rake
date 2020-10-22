desc 'update players price'
task update_price: :environment do
  Player.all.each do |player|
  	require 'nokogiri'
  	require 'open-uri'
    
    doc = Nokogiri::HTML(open("#{player.url}"))

    @prev = doc.css('#pslbin').text

    @price = @prev.to_i * 1000

    player.prices.build(price: "#{@price}")
    player.current = @price
    player.save

    if player.buy.to_i != 0 && player.buy.present?
      if player.prices.last.price.to_i <= player.buy.to_i && player.mail && player.prices.last.price.to_i > 0
      	UserMailer.buy_players(player).deliver_now
      end
    end
    if player.sell.to_i != 0 && player.sell.present?
      if player.prices.last.price.to_i >= player.sell.to_i && player.mail && player.prices.last.price.to_i > 0
      	UserMailer.sell_players(player).deliver_now
      end
    end
  end
end