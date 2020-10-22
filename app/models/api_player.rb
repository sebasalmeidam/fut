class ApiPlayer < ActiveRecord::Base

	def self.search(search)
		if search
			where('LOWER(player_name) LIKE LOWER(?) OR LOWER("firstName") LIKE LOWER(?) OR LOWER("lastName") LIKE LOWER(?) OR LOWER("commonName") LIKE LOWER(?) OR LOWER(club) LIKE LOWER(?)', "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%", "%#{search}%")
		else
			all
		end
	end

	def self.fposition(fposition)
		if fposition
			where(position: fposition)
		else
			all
		end
	end

	def self.frating(rating_min, rating_max)
		if rating_min && rating_max == ""
			max = 99
			where(rating: (rating_min.to_i..max))
		elsif rating_max && rating_min == ""
			rating_min = 1
			where(rating: (rating_min..rating_max.to_i))
		elsif rating_min && rating_max
			where(rating: (rating_min..rating_max))
		else
			all
		end
	end

	def self.fnation(fnation)
		if fnation
			where(nation: fnation)
		else
			all
		end
	end

end
