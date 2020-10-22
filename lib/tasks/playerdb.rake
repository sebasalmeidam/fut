desc 'add players from fifa api'
task playerdb: :environment do
	require 'json'

	require 'nokogiri'
	require 'open-uri'
    
    #encoded_url = CGI::escape(@player.url)
  
  url = "https://www.easports.com/fifa/ultimate-team/api/fut/item?"
    
  doc = Nokogiri::HTML(open(url))
  prev = JSON.parse(doc)
  
  page = prev['page'].to_i
  max_page = prev['totalPages'].to_i
  pages_range = (page..max_page).to_a

  i = 0

  pages_range.each do |p|
  	
  	url2 = "https://www.easports.com/fifa/ultimate-team/api/fut/item?page=#{p}"
  	
  	doc = Nokogiri::HTML(open(url2))
  	web = JSON.parse(doc)

  	items = web['items']

	  items.each do |item|
	  	player_name					= item['name']
	  	commonName 					= item['commonName']
			firstName						= item['firstName']
			lastName						= item['lastName']
	  	quality 						= item['quality']
	  	color 							= item['color']
	  	isGK 								= item['isGK']
	  	baseId 							= item['baseId']
	  	playerdb_id					= item['id']
	  	rating	 						= item['rating']
	  	league 							= item['league']['name']
	  	league_abbr 				= item['league']['abbrName']
	  	nation 							= item['nation']['name']
	  	nation_img_small		= item['nation']['imageUrls']['small']
	  	nation_img_large		= item['nation']['imageUrls']['large']
	  	club								= item['club']['name']
	  	club_img_small			= item['club']['imageUrls']['normal']['small']
	  	club_img_large			= item['club']['imageUrls']['normal']['large']
	  	headshot_img_small	= item['headshot']['smallImgUrl']
	  	headshot_img_large	= item['headshot']['largeImgUrl']
	  	special_img_small		= item['specialImages']['medTOTWImgUrl']
	  	special_img_large 	= item['specialImages']['largeTOTWImgUrl']
	  	position 						= item['position']
	  	height 							= item['height']
	  	weight 							= item['weight']
	  	birthdate 					= item['birthdate']
	  	age 								= item['age']
	  	acceleration 				= item['acceleration']
	  	aggression 					= item['aggression']
	  	agility 						= item['agility']
	  	balance 						= item['balance']
	  	ballcontrol 				= item['ballcontrol']
	  	foot 								= item['foot']
	  	skillMoves 					= item['skillMoves']
	  	crossing 						= item['crossing']
	  	curve 							= item['curve']
	  	dribbling 					= item['dribbling']
	  	finishing 					= item['finishing']
	  	freekickaccuracy 		= item['freekickaccuracy']
	  	gkdiving 						= item['gkdiving']
	  	gkhandling 					= item['gkhandling']
	  	gkkicking 					= item['gkkicking']
	  	gkpositioning 			= item['gkpositioning']
	  	gkreflexes 					= item['gkreflexes']
	  	headingaccuracy 		= item['headingaccuracy']
	  	interceptions 			= item['interceptions']
	  	jumping 						= item['jumping']
	  	longpassing 				= item['longpassing']
	  	longshots 					= item['longshots']
	  	marking 						= item['marking']
	  	penalties 					= item['penalties']
	  	positioning 				= item['positioning']
	  	potential 					= item['potential']
	  	reactions 					= item['reactions']
	  	shortpassing 				= item['shortpassing']
	  	shotpower 					= item['shotpower']
	  	slidingtackle 			= item['slidingtackle']
	  	sprintspeed 				= item['sprintspeed']
	  	standingtackle 			= item['standingtackle']
	  	stamina 						= item['stamina']
	  	strength 						= item['strength']
	  	vision 							= item['vision']
	  	volleys 						= item['volleys']
	  	weakFoot 						= item['weakFoot']
	  	traits 							= item['traits'].join(", ") if !item['traits'].nil?
	  	specialities 				= item['specialities'].join(", ") if !item['specialities'].nil?
	  	atkWorkRate 				= item['atkWorkRate']
	  	defWorkRate 				= item['defWorkRate']
	  	playerType 					= item['playerType']
	  	attr_1_val 					= item['attributes'][0]['value']
	  	attr_2_val		 			= item['attributes'][1]['value']
	  	attr_3_val 					= item['attributes'][2]['value']
	  	attr_4_val 					= item['attributes'][3]['value'] 
	  	attr_5_val 					= item['attributes'][4]['value'] 
	  	attr_6_val 					= item['attributes'][5]['value']
	  	attr_1_name 				= item['attributes'][0]['name'].last(3)
	  	attr_2_name		 			= item['attributes'][1]['name'].last(3)
	  	attr_3_name 				= item['attributes'][2]['name'].last(3)
	  	attr_4_name 				= item['attributes'][3]['name'].last(3)
	  	attr_5_name 				= item['attributes'][4]['name'].last(3)
	  	attr_6_name 				= item['attributes'][5]['name'].last(3)

		  if !ApiPlayer.find_by(playerdb_id: playerdb_id)
		  new_player =	ApiPlayer.new(
				player_name: player_name,
				commonName: commonName,
				firstName: firstName,
				lastName: lastName,
				quality: quality,
				color: color,
				isGK: isGK,
				baseId: baseId,
				playerdb_id: playerdb_id,
				rating: rating,
				league: league,
				league_abbr: league_abbr,
				nation: nation,
				nation_img_small: nation_img_small,
				nation_img_large: nation_img_large,
				club: club,
				club_img_small: club_img_small,
				club_img_large: club_img_large,
				headshot_img_small: headshot_img_small,
				headshot_img_large: headshot_img_large,
				special_img_small: special_img_small,
				special_img_large: special_img_large,
				position: position,
				height: height,
				weight: weight,
				birthdate: birthdate,
				age: age,
				acceleration: acceleration,
				aggression: aggression,
				agility: agility,
				balance: balance,
				ballcontrol: ballcontrol,
				foot: foot,
				skillMoves: skillMoves,
				crossing: crossing,
				curve: curve,
				dribbling: dribbling,
				finishing: finishing,
				freekickaccuracy: freekickaccuracy,
				gkdiving: gkdiving,
				gkhandling: gkhandling,
				gkkicking: gkkicking,
				gkpositioning: gkpositioning,
				gkreflexes: gkreflexes,
				headingaccuracy: headingaccuracy,
				interceptions: interceptions,
				jumping: jumping,
				longpassing: longpassing,
				longshots: longshots,
				marking: marking,
				penalties: penalties,
				positioning: positioning,
				potential: potential,
				reactions: reactions,
				shortpassing: shortpassing,
				shotpower: shotpower,
				slidingtackle: slidingtackle,
				sprintspeed: sprintspeed,
				standingtackle: standingtackle,
				stamina: stamina,
				strength: strength,
				vision: vision,
				volleys: volleys,
				weakFoot: weakFoot,
				traits: traits,
				specialities: specialities,
				atkWorkRate: atkWorkRate,
				defWorkRate: defWorkRate,
				playerType: playerType,
				attr_1_val: attr_1_val,
				attr_2_val: attr_2_val,
				attr_3_val: attr_3_val,
				attr_4_val: attr_4_val,
				attr_5_val: attr_5_val,
				attr_6_val: attr_6_val,
				attr_1_name: attr_1_name,
				attr_2_name: attr_2_name,
				attr_3_name: attr_3_name,
				attr_4_name: attr_4_name,
				attr_5_name: attr_5_name,
				attr_6_name: attr_6_name
			)
			new_player.save

			end

	  end

	  i = i + 1
	  puts i

	end

end