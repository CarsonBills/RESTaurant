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
	def print_receipt
		receipt = self.foods
		prices = receipt.map {|item| item[:price]}
		total = prices.inject(:+)
		file = File.open('public/receipts/receipt.txt', 'w')
		file.write ("               Aioli\n")
		file.write ("**********************************\n")
		file.write (receipt.map {|item| item.to_s+"\n"}.join.to_s)
		file.write ("\n")
		file.write  ("Your total comes to #{total} dollars\n")
		file.write ("Tip Suggestions:\n")
		file.write ("15%  -  #{total*0.15.round(2)}\n")
		file.write ("20%  -  #{total*0.20.round(2)}\n")
		file.write ("25%  -  #{total*0.25.round(2)}\n")
		file.write ("\n")
		file.write ("Subtotal: $#{total}\n")
		file.write ("\n")
		file.write ("tip: _____________________________\n")
		file.write ("total:____________________________\n")
		file.write ("\n")
		file.write ("__________________________________\n")
		file.write ("             Signature\n")
		file.close 
	end
end