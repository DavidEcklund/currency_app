require "test_helper"

class EuroExchangeRatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @euro_exchange_rate = euro_exchange_rates(:one)
  end

  test "should get index" do
    get euro_exchange_rates_url
    assert_response :success
  end

  test "should get new" do
    get new_euro_exchange_rate_url
    assert_response :success
  end

  test "should create euro_exchange_rate" do
    assert_difference('EuroExchangeRate.count') do
      post euro_exchange_rates_url, params: { euro_exchange_rate: { currency_pair: @euro_exchange_rate.currency_pair, exchange_date: @euro_exchange_rate.exchange_date, exchange_rate: @euro_exchange_rate.exchange_rate } }
    end

    assert_redirected_to euro_exchange_rate_url(EuroExchangeRate.last)
  end

  test "should show euro_exchange_rate" do
    get euro_exchange_rate_url(@euro_exchange_rate)
    assert_response :success
  end

  test "should get edit" do
    get edit_euro_exchange_rate_url(@euro_exchange_rate)
    assert_response :success
  end

  test "should update euro_exchange_rate" do
    patch euro_exchange_rate_url(@euro_exchange_rate), params: { euro_exchange_rate: { currency_pair: @euro_exchange_rate.currency_pair, exchange_date: @euro_exchange_rate.exchange_date, exchange_rate: @euro_exchange_rate.exchange_rate } }
    assert_redirected_to euro_exchange_rate_url(@euro_exchange_rate)
  end

  test "should destroy euro_exchange_rate" do
    assert_difference('EuroExchangeRate.count', -1) do
      delete euro_exchange_rate_url(@euro_exchange_rate)
    end

    assert_redirected_to euro_exchange_rates_url
  end
end
