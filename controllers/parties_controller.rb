class PartiesController < ApplicationController

  get '/' do
    @parties = Party.all
    erb :'parties/index'
  end

  get '/new' do
    erb :'parties/new'
  end

  post '/' do
    Party.create(params[:party])
    redirect '/parties'
  end

  get '/:id' do
    @party = Party.find(params[:id])
    @foods = Food.all
    @paid = @party.paid
    erb :"parties/show"
  end

  get '/:id/edit' do
    @party = Party.find(params[:id])
    @paid = @party.paid
    erb :"parties/edit"
  end

  patch '/:id' do
    party = Party.find(params[:id])
    party.update(params[:party])
    redirect "/parties/#{party.id}"
  end

  delete '/:id' do
    Party.delete(params[:id])
    redirect "/parties"
  end

  post '/:id' do
    @party = Party.find(params[:id])
    @party.print_receipt
    redirect "/parties/#{@party.id}/receipt"
  end

  get '/:id/receipt' do
    party = Party.find(params[:id])
    receipt = party.foods
    prices = receipt.map {|item| item[:price]}
    @total = prices.inject(:+)
    @receipt_items = File.read('public/receipts/receipt.txt').split("\n")
    erb :"parties/receipt"
  end

  patch '/:id/checkout' do
    party = Party.find(params[:id])
    party.update(params[:party])
    redirect "/parties/#{params[:party][:id]}"
  end

end