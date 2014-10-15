class Food < ActiveRecord::Base
	has_many(:orders)
	has_many(:parties, through: :orders)
	def to_s
		"#{name}   -    #{price},"
	end
end