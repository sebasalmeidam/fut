module PlayersHelper

	def get_price(player)
		unless player.url == ""
      require 'nokogiri'
      require 'open-uri'
      
      doc = Nokogiri::HTML(open("#{player.url}"))
      @price = doc.css('#pslbin').text
      "#{@price}"
    end
  end

  def today_prices
  	@player.prices.where(created_at: Date.today.in_time_zone(-5)..Time.now).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end
  
  def yesterday_prices
  	@player.prices.where(created_at: (Date.today.in_time_zone(-5)-1.days)..Date.today.in_time_zone(-5)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end
  
  def last_2d_prices
  	@player.prices.where(created_at: (Date.today.in_time_zone(-5)-2.days)..(Date.today.in_time_zone(-5)-1.days)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_3d_prices
    @player.prices.where(created_at: (Date.today.in_time_zone(-5)-3.days)..(Date.today.in_time_zone(-5)-2.days)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end
  
  def last_week_prices
  	@player.prices.where(created_at: (Time.now - 7.days)..Time.now).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_month_prices
  	@player.prices.where(created_at: (Time.now - 1.months)..Time.now).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_hour_prices
  	@player.prices.where(created_at: (Time.now - 1.hours)..Time.now).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_2h_prices
    @player.prices.where(created_at: (Time.now - 2.hours)..(Time.now - 1.hours)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_3h_prices
  	@player.prices.where(created_at: (Time.now - 3.hours)..(Time.now - 2.hours)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_6h_prices
  	@player.prices.where(created_at: (Time.now - 6.hours)..(Time.now - 5.hours)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_9h_prices
    @player.prices.where(created_at: (Time.now - 9.hours)..(Time.now - 8.hours)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def last_12h_prices
  	@player.prices.where(created_at: (Time.now - 12.hours)..(Time.now - 11.hours)).collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def historic_prices
    @player.prices.collect(&:price).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
  end

  def search_period
    if params[:date] == 'today'
      start = Date.today.in_time_zone(-5).to_s
      finish = Time.now.in_time_zone(-5).to_s
      @period_prices = @player.prices.where(created_at: start..finish)
    elsif params[:date] == 'yesterday'
      start = (Date.today - 1).in_time_zone(-5).to_s
      finish = Date.today.in_time_zone(-5).to_s
      @period_prices = @player.prices.where(created_at: start..finish)
    elsif params[:date] == 'last_month'
      start = (Time.now - 1.months).in_time_zone(-5).to_s
      finish = Time.now.in_time_zone(-5).to_s
      @period_prices = @player.prices.where(created_at: start..finish)
    else
      @period_prices = @player.prices
    end
  end

  #Proyecciones


  def last_hours_projection(horas, tiempo)
    line = LineFit.new
    if !@player.prices.where(created_at: (Time.now - horas.hours)..(Time.now)).nil?
      x_data = @player.prices.where(created_at: (Time.now - horas.hours)..(Time.now)).where('price > ?', 0).collect(&:created_at).map(&:to_f).reject(&:nan?).reject{|v| v == 0}
      y_data = historic_prices.last(x_data.count)
      x_data.count > 0 && y_data.count > 0
      line.setData(x_data,y_data) 
      newx_data = (@player.prices.last.created_at + tiempo.minutes).to_f
      begin
        line.forecast(newx_data).to_i if !line.forecast(newx_data).nil?
      rescue NoMethodError
        @player.current.to_i
      end
    else 
      @player.current.to_i
    end
    
  end


end
