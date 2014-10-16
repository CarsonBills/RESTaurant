class Party < ActiveRecord::Base
	has_many(:orders)
	has_many(:foods, through: :orders)

	class TicketClosedError < StandardError
	end

	def add_food(food)
		check_ticket_closed
		self.foods << food
	end

	def check_ticket_closed
		if self.paid == true
			raise(TicketClosedError, "That ticket for this party has already been closed.")
		end
	end
end