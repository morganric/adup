class AdsController < ApplicationController
  before_action :set_ad, only: [:show, :edit, :update, :destroy, :forward]

  # GET /ads
  # GET /ads.json
  def index
    @ads = Ad.all
  end

  # GET /ads/1
  # GET /ads/1.json
  def show
  end

  # GET /ads/1
  # GET /ads/1.json
  def forward

    @ad.clicks = @ad.clicks.to_i + 1
    @ad.save

    redirect_to @ad.url()

  end

  # GET /ads/new
  def new
    @ad = Ad.new
  end

  # GET /ads/1/edit
  def edit
  end

  # POST /ads
  # POST /ads.json
  def create

      # Amount in cents

      @amount = (params[:impressions].to_i / 1000) * 10


      @ad = Ad.new()
      if current_user
        @ad.user_id = current_user.id
      end
      #@ad.title = params[:title]
      @ad.impressions = params[:impressions].to_i
      @ad.image = params[:image]
      @ad.url = params[:url]
      @ad.website_id = params[:website_id].to_i
      @ad.views = 0
      

      customer = Stripe::Customer.create(
        :email => params[:stripeEmail],
        :card  => params[:stripeToken]
      )

      charge = Stripe::Charge.create(
        :customer    => customer.id,
        :amount      => @amount * 100,
        :description => 'AdUp Ad Units',
        :currency    => 'usd'
      )

      @ad.save

    redirect_to ad_path(@ad)

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to ad_path(@ad)

     redirect_to :back




    # @ad = Ad.new(ad_params)

    # respond_to do |format|
    #   if @ad.save
    #     format.html { redirect_to @ad, notice: 'Ad was successfully created.' }
    #     format.json { render :show, status: :created, location: @ad }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @ad.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /ads/1
  # PATCH/PUT /ads/1.json
  def update
    respond_to do |format|
      if @ad.update(ad_params)
        format.html { redirect_to @ad, notice: 'Ad was successfully updated.' }
        format.json { render :show, status: :ok, location: @ad }
      else
        format.html { render :edit }
        format.json { render json: @ad.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ads/1
  # DELETE /ads/1.json
  def destroy
    @ad.destroy
    respond_to do |format|
      format.html { redirect_to ads_url, notice: 'Ad was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ad
      @ad = Ad.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ad_params
      params.require(:ad).permit(:url, :impressions, :user_id, :image, :views, :live, :clicks, :title, :slug, :website_id)
    end
end
