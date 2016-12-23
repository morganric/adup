class ChargesController < ApplicationController

	def new
end

def create
  # Amount in cents
  @amount = params[:amount].to_i

  @ad = Photo.new()
  @ad.title = params[:title]
  @ad.image= params[:image]
  @ad.website_id = params[:website_id].to_i
  @ad.save

  customer = Stripe::Customer.create(
    :email => 'example@stripe.com',
    :card  => params[:stripeToken]
  )

  charge = Stripe::Charge.create(
    :customer    => customer.id,
    :amount      => @amount * 100,
    :description => 'Ad Purchase',
    :currency    => 'usd'
  )

rescue Stripe::CardError => e
  flash[:error] = e.message
  redirect_to charges_path
end


end
