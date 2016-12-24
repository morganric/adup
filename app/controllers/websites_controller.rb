class WebsitesController < ApplicationController
  before_action :set_website, only: [:show, :edit, :update, :destroy, :display]

  before_filter :authenticate_user!,  except: [:index, :show, :display]

  after_filter :allow_iframe

  # GET /websites
  # GET /websites.json
  def index
    @websites = Website.all
  end

  # GET /websites/1
  # GET /websites/1.json
  def show


      Rails.configuration.stripe = {
      :publishable_key =>  ENV['PUBLISHABLE_KEY'] ,
      :secret_key      =>  ENV['SECRET_KEY']
      }

      Stripe.api_key = Rails.configuration.stripe[:secret_key]
      # Stripe.api_key = @campaign.user.stripe_secret_key

      @publishable_key = Rails.configuration.stripe[:publishable_key]


  end

  # GET /websites/1
  # GET /websites/1.json
  def display

    @ads = @website.ads.where("views < impressions").order("created_at DESC")

    @ad = @ads.first

    @parent = params[:parent]

    render layout: "display"
  end


  # GET /websites/1
  # GET /websites/1.json
  def house 

    @website  = Website.find_by_url(params[:url])

    render layout: "display"
  end

  # GET /websites/new
  def new
    @website = Website.new
  end

  # GET /websites/1/edit
  def edit
  end

  # POST /websites
  # POST /websites.json
  def create
    @website = Website.new(website_params)

    @website.user_id = current_user.id

    respond_to do |format|
      if @website.save
        format.html { redirect_to @website, notice: 'Website was successfully created.' }
        format.json { render :show, status: :created, location: @website }
      else
        format.html { render :new }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /websites/1
  # PATCH/PUT /websites/1.json
  def update
    respond_to do |format|
      if @website.update(website_params)
        format.html { redirect_to @website, notice: 'Website was successfully updated.' }
        format.json { render :show, status: :ok, location: @website }
      else
        format.html { render :edit }
        format.json { render json: @website.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /websites/1
  # DELETE /websites/1.json
  def destroy
    @website.destroy
    respond_to do |format|
      format.html { redirect_to websites_url, notice: 'Website was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private


    def allow_iframe
      response.headers['X-Frame-Options'] = "ALLOWALL"
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_website
      @website = Website.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def website_params
      params.require(:website).permit(:url, :user_id, :active, :disabled, :price, :image)
    end
end
