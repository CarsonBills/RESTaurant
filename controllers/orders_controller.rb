class OrdersController < ApplicationController

post '/' do
  food = Food.find(params[:food][:id])
  @party = Party.find(params[:party][:id])
  begin
    @party.add_food(food)
    redirect "/parties/#{@party.id}"
  rescue Party::TicketClosedError => e
    @error = e.message
    erb :'parties/error'
  end
end

delete '/:id' do
  Order.delete(params[:id])
  redirect "/parties/#{params[:party][:id]}"
end

end