class EuroExchangeRatesController < ApplicationController
  before_action :set_euro_exchange_rate, only: [:show, :edit, :update, :destroy]

  # GET /euro_exchange_rates
  # GET /euro_exchange_rates.json
  def index
    @euro_exchange_rates = EuroExchangeRate.all
    
    #Setting up gem
    require 'money/bank/currencylayer_bank'
    @mclb = Money::Bank::CurrencylayerBank.new
    @mclb.access_key = '449c64b1f17fc3a048e0ef51fec42c6d'
    Money.default_infinite_precision = true
    @mclb.cache = 'tmp.json'
  
    # prevents multiple users from initializing multiple daily jobs
    initialize_scheduled_job unless job_scheduled?
    
    json = File.read('tmp.json')
    initialize_current_rates(json)
    load_current_rates_into_db
  end
  
  def load_current_rates_into_db
    unless todays_rates_in_db?
      @current_rates.each do |currencies, rate|
        EuroExchangeRate.create(exchange_date: Date.today,
                                currency_pair: currencies,
                                exchange_rate: rate)
      end
    end
  end
  
  def job_scheduled?
    File.read('job.txt').length > 0
  end
  
  def api_call
    @mclb.update_rates
    puts File.read("tmp.json") 
  end

  def initialize_scheduled_job
    puts "Initializing scheduled job"
    
    if File.read('tmp.json').length == 0 ||
       !todays_rates_in_db?  &&  (Time.now > Time.parse("07:00 am"))
          api_call
          puts "Getting today's rates."
    end
    
    job_id =
      Rufus::Scheduler.singleton.cron '0 7 * * *' do # UTC on heroku is default
        api_call
      end      
    job_txt = File.open('job.txt', "a")
    job_txt.write("Started cron job_id: " + job_id)
    job_txt.close
    puts File.read('job.txt') + "\n"       
  end
  
  def todays_rates_in_db?
    @euro_exchange_rates.any? {|rate| rate[:exchange_date] == Date.today}
  end
  
  def initialize_current_rates(json)
    quotes = JSON.parse(json)["quotes"]
    @current_rates = {"USDEUR" => quotes["USDEUR"]}
    @current_rates["EURUSD"] = 1 / @current_rates["USDEUR"]
    @current_rates["EURCHF"] = @current_rates["USDEUR"] / quotes["USDCHF"]
    @current_rates["CHFEUR"] = 1 / @current_rates["EURCHF"]
  end

  # # GET /euro_exchange_rates/1
  # # GET /euro_exchange_rates/1.json
  # def show
  # end

  # # GET /euro_exchange_rates/new
  # def new
  #   @euro_exchange_rate = EuroExchangeRate.new
  # end

  # # GET /euro_exchange_rates/1/edit
  # def edit
  # end

  # POST /euro_exchange_rates
  # POST /euro_exchange_rates.json
  def create
    @euro_exchange_rate = EuroExchangeRate.new(euro_exchange_rate_params)

    respond_to do |format|
      if @euro_exchange_rate.save
        format.html { redirect_to @euro_exchange_rate, notice: 'Euro exchange rate was successfully created.' }
        format.json { render :show, status: :created, location: @euro_exchange_rate }
      else
        format.html { render :new }
        format.json { render json: @euro_exchange_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # # PATCH/PUT /euro_exchange_rates/1
  # # PATCH/PUT /euro_exchange_rates/1.json
  # def update
  #   respond_to do |format|
  #     if @euro_exchange_rate.update(euro_exchange_rate_params)
  #       format.html { redirect_to @euro_exchange_rate, notice: 'Euro exchange rate was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @euro_exchange_rate }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @euro_exchange_rate.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /euro_exchange_rates/1
  # # DELETE /euro_exchange_rates/1.json
  # def destroy
  #   @euro_exchange_rate.destroy
  #   respond_to do |format|
  #     format.html { redirect_to euro_exchange_rates_url, notice: 'Euro exchange rate was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_euro_exchange_rate
      @euro_exchange_rate = EuroExchangeRate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def euro_exchange_rate_params
      params.require(:euro_exchange_rate).permit(:exchange_date, :currency_pair, :exchange_rate)
    end
end
