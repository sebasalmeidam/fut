module ApiPlayersHelper

	def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == "desc" ? "asc" : "desc"
    icon = sort_direction == "asc" ? "glyphicon glyphicon-chevron-up" : "glyphicon glyphicon-chevron-down"
    icon = column == sort_column ? icon : ""
    link_to "#{title} <span class='#{icon}'></span>".html_safe, {column: column, direction: direction, page: params[:page], search: params[:search]}, remote: true
  end

  def sort_column
    sortable_columns.include?(params[:column]) ? params[:column] : "rating"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "desc"
  end

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

  def name_color
    case @player.color
      when 'gotm', 'toty', 'record_breaker', 'confederation_champions_motm', 'base_sbc', 'cmotm', 'imotm', 'fut_birthday', 'motm'
        'colorNameWhite'
      when 'purple'
        'colorNameHero'
      when 'ones_to_watch'
        'colorNameOTW'
      when 'totw_gold'
        'colorNameTotwGold'
      when 'totw_silver'
        'colorNameTotwSilver'
      when 'totw_bronze'
        'colorNameTotwBronze'
      when 'legend'
        'colorNameLegend'
      when 'award_winner'
        'colorNamePurple'
      when 'movember'
        'colorNameMovember'
      when 'st_patricks'
        'colorNameStPatricks'
      else 
        'colorNameDefault'
    end
  end

  def attr_color
    case @player.color
      when 'gotm', 'toty', 'record_breaker', 'confederation_champions_motm', 'base_sbc','cmotm', 'imotm', 'fut_birthday', 'award_winner', 'motm'
        'colorNameWhite'
      when 'purple'
        'attrNameHero'
      when  'ones_to_watch'
        'attrNameOTW'
      when 'totw_silver'
        'colorNameTotwSilver'
      when 'totw_gold'
        'colorNameTotwGold'
      when 'totw_bronze'
        'colorNameTotwBronze'
      when 'legend'
        'colorNameLegend'
      when 'movember'
        'colorNameMovember'
      when 'st_patricks'
        'colorNameStPatricks'
      else 
        'colorNameDefault'
    end
  end

  def rating_color
    case @player.color
      when 'gotm', 'toty', 'record_breaker', 'base_sbc', 'cmotm', 'imotm', 'fut_birthday', 'award_winner'
        'colorNameWhite'
      when 'purple'
        'attrNameHero'
      when 'motm'
        'ratingNameMOTM'
      when  'ones_to_watch'
        'attrNameOTW'
      when 'legend'
        'colorNameLegend'
      when 'movember'
        'colorNameMovember'
      when 'st_patricks'
        'colorNameStPatricks'
      when 'confederation_champions_motm'
        'attrNameCMOTM'
      else 
        'colorNameDefault'
    end
  end

end
