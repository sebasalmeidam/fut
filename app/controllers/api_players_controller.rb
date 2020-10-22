class ApiPlayersController < ApplicationController

  def index
  	@players = ApiPlayer.search(params[:search]).fposition(params[:filter]).frating(params[:rating_min], params[:rating_max]).fnation(params[:nation]).order("#{sort_column} #{sort_direction}").paginate(:page => params[:page], :per_page => 20)
  	
  end

  def show
    @player = ApiPlayer.find(params[:id])
  end

  private

  def sortable_columns
    ['color', 'rating', 'attr_1_val', 'attr_2_val', 'attr_3_val', 'attr_4_val', 'attr_5_val', 'attr_6_val', 'skillMoves', 'weakFoot', 'acceleration',
'aggression',
'agility',
'balance',
'ballcontrol',
'crossing',
'curve',
'dribbling',
'finishing',
'freekickaccuracy',
'gkdiving',
'gkhandling',
'gkkicking',
'gkpositioning',
'gkreflexes',
'headingaccuracy',
'interceptions',
'jumping',
'longpassing',
'longshots',
'marking',
'penalties',
'positioning',
'potential',
'reactions',
'shortpassing',
'shotpower',
'slidingtackle',
'sprintspeed',
'standingtackle',
'stamina',
'strength',
'vision',
'volleys',
     ]
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "rating"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

end
