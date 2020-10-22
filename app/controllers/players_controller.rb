class PlayersController < ApplicationController

  before_action :authenticate_user!, except: [:player_list, :edit_mail, :edit_buyed]
  
  def index
  	if current_user
      @players = current_user.players.order(:buyed, current: :desc)
            
    else
      flash[:notice] = "Por favor, inicia sesión para ver este contenido."
      redirect_to iniciar_sesion_path
    end

  end

  def show
  	@player = Player.find(params[:id])

    if current_user.id == @player.user_id
    
    @prices = @player.prices.order(updated_at: :desc).paginate(:page => params[:page], :per_page => 8)
      
    #  require 'nokogiri'
    #  require 'open-uri'
      

      #encoded_url = CGI::escape(@player.url)
      
    #  doc = Nokogiri::HTML(open(@player.url))
    #  @prev = doc.css('#pslbin').text
    #  @price = @prev.to_i * 1000
    #  @player.current = @price
    #  @player.prices.build(price: @price)
    # @player.save


    else
      flash[:notice] = "No tienes autorización para ver este contenido"
      redirect_to players_path
    end

    @sale = Sale.new
    
  end

  def new
  	@player = Player.new
  end

  def create
  	@player = Player.new(player_params)
  	if @player.save
  		redirect_to player_path(@player)
  	else
  		flash.now[:notice] = "Jugador no ha sido agregado."
  		render 'new'
  	end
  end


  def edit
  	@player = Player.find(params[:id])
    unless current_user.id == @player.user.id
      flash[:notice] = "No tienes permiso para realizar esta acción."
      redirect_to players_path
    end
  end

  def update
  	@player = Player.find(params[:id])
  	
  	if @player.update_attributes(player_params)
  		redirect_to players_path
  	else
  		flash.now[:notice] = "Jugador no ha sido editado."
  		render 'edit'
  	end
  end

  def destroy
  	@player = Player.find(params[:id])
  	@player.destroy
  	flash[:notice] = "Jugador #{@player.player} ha sido eliminado."
  	redirect_to players_path
  end

  def player_list
    require 'rubygems'
    require 'mechanize'
    require 'open-uri'

    @counter = []
   
    @listings = []
    @names = []
    @rates = []
    @types = []
    @positions = []
    @prices = []
    @images = []

    if params[:search]

      openuri_params = {
        # set timeout durations for HTTP connection
        # default values for open_timeout and read_timeout is 60 seconds
        :open_timeout => 10,
        :read_timeout => 10,
      }

      attempt_count = 0
      max_attempts  = 3
      begin
        attempt_count += 1
        attempt_notice = "attempt ##{attempt_count}"
        content = open("https://www.futbin.com/17/players", openuri_params).read
      rescue OpenURI::HTTPError => e
        flash[:notice] = "Base de precios de jugadores no responde."
        redirect_to user_path(current_user)
        # it's 404, etc. (do nothing)
      rescue SocketError, Net::ReadTimeout => e
        flash[:notice] = "Base de precios de jugadores no responde."
        redirect_to user_path(current_user)
        # server can't be reached or doesn't send any respones
        sleep 3
        retry if attempt_count < max_attempts
        redirect_to user_path(current_user)
      else

        @player = params[:search]
        web_page = "https://www.futbin.com/17/players?search=#{@player}"

        agent = Mechanize.new
        page = agent.get(web_page)

        @listings = page.links_with(href: %r{/player/} ).collect(&:href)
        @names = page.links_with(href: %r{/player/} ).collect(&:text)
        @rates = Nokogiri::HTML(page.body).css('span.rating').collect(&:text)
        @types = Nokogiri::HTML(page.body).css('td:nth-child(4)').collect(&:text)
        @positions = Nokogiri::HTML(page.body).css('td:nth-child(3)').collect(&:text)
        @prices = Nokogiri::HTML(page.body).css('.ps4_color').collect(&:text)
          Nokogiri::HTML(page.body.to_s).css('img.player_img').each do |image|
            img = image['src']
            @images << img
          end
        
        if @listings.count > 0
          @count = @listings.count - 1
          @counter = (0..@count).to_a
          
        end
      end
    end  
  end

  def edit_mail
    @player = Player.find(params[:id])
    if @player.mail
      @player.mail = false
      @player.save
      flash[:notice] = "Ya no recibirás más notificaciones de #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    else
      @player.mail = true
      @player.save
      flash[:notice] = "Desde ahora recibirás notificaciones de #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    end
  end

  def edit_buyed
    @player = Player.find(params[:id])
    if @player.buyed
      @player.buyed = false
      @player.save
      flash[:notice] = "Has vendido un jugador: #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    else
      @player.buyed = true
      @player.save
      flash[:notice] = "Has comprado un jugador: #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    end
  end

  def edit_track
    @player = Player.find(params[:id])
    if @player.track
      @player.track = false
      @player.save
      flash[:notice] = "Has guardado un jugador: #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    else
      @player.track = true
      @player.save
      flash[:notice] = "Ahora sigues a un jugador: #{@player.player if @player.player}."
      if current_user
        redirect_to players_path
      else
        redirect_to unauthenticated_root_path
      end
    end
  end

  def update_prices
    @players = current_user.players

    require 'nokogiri'
    require 'open-uri'

    openuri_params = {
      # set timeout durations for HTTP connection
      # default values for open_timeout and read_timeout is 60 seconds
      :open_timeout => 10,
      :read_timeout => 10,
    }

    attempt_count = 0
    max_attempts  = 3
    begin
      attempt_count += 1
      attempt_notice = "attempt ##{attempt_count}"
      content = open("https://www.futbin.com/17/players", openuri_params).read
    rescue OpenURI::HTTPError => e
      flash[:notice] = "Base de precios de jugadores no responde."
      redirect_to user_path(current_user)
      # it's 404, etc. (do nothing)
    rescue SocketError, Net::ReadTimeout => e
      flash[:notice] = "Base de precios de jugadores no responde."
      redirect_to user_path(current_user)
      # server can't be reached or doesn't send any respones
      sleep 3
      retry if attempt_count < max_attempts
    else

      @players.each do |player|
        
        #encoded_url = CGI::escape(@player.url)
        
        doc = Nokogiri::HTML(open(player.url))


        @prev = doc.css('#pslbin').text
        @price = @prev.to_i * 1000          
        player.current = @price
        player.prices.build(price: "#{@price}")
        player.save
        
      end
    end
    redirect_to players_path
  end
  
  private

  	def player_params
  		params.require(:player).permit(:player, :url, :buy, :sell, :mail, :img, :tp, :user_id, :track)
  	end


    
end


