class EuroExchangeRatesController < ApplicationController
  before_action :set_euro_exchange_rate, only: [:show, :edit, :update, :destroy]

  # GET /euro_exchange_rates
  # GET /euro_exchange_rates.json
  def index
    @euro_exchange_rates = EuroExchangeRate.all
  end

  # GET /euro_exchange_rates/1
  # GET /euro_exchange_rates/1.json
  def show
  end

  # GET /euro_exchange_rates/new
  def new
    @euro_exchange_rate = EuroExchangeRate.new
  end

  # GET /euro_exchange_rates/1/edit
  def edit
  end

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

  # PATCH/PUT /euro_exchange_rates/1
  # PATCH/PUT /euro_exchange_rates/1.json
  def update
    respond_to do |format|
      if @euro_exchange_rate.update(euro_exchange_rate_params)
        format.html { redirect_to @euro_exchange_rate, notice: 'Euro exchange rate was successfully updated.' }
        format.json { render :show, status: :ok, location: @euro_exchange_rate }
      else
        format.html { render :edit }
        format.json { render json: @euro_exchange_rate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /euro_exchange_rates/1
  # DELETE /euro_exchange_rates/1.json
  def destroy
    @euro_exchange_rate.destroy
    respond_to do |format|
      format.html { redirect_to euro_exchange_rates_url, notice: 'Euro exchange rate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

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
