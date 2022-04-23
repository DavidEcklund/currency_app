require "application_system_test_case"

class EuroExchangeRatesTest < ApplicationSystemTestCase
  setup do
    @euro_exchange_rate = euro_exchange_rates(:one)
  end

  test "visiting the index" do
    visit euro_exchange_rates_url
    assert_selector "h1", text: "Euro Exchange Rates"
  end

  test "creating a Euro exchange rate" do
    visit euro_exchange_rates_url
    click_on "New Euro Exchange Rate"

    fill_in "Currency pair", with: @euro_exchange_rate.currency_pair
    fill_in "Exchange date", with: @euro_exchange_rate.exchange_date
    fill_in "Exchange rate", with: @euro_exchange_rate.exchange_rate
    click_on "Create Euro exchange rate"

    assert_text "Euro exchange rate was successfully created"
    click_on "Back"
  end

  test "updating a Euro exchange rate" do
    visit euro_exchange_rates_url
    click_on "Edit", match: :first

    fill_in "Currency pair", with: @euro_exchange_rate.currency_pair
    fill_in "Exchange date", with: @euro_exchange_rate.exchange_date
    fill_in "Exchange rate", with: @euro_exchange_rate.exchange_rate
    click_on "Update Euro exchange rate"

    assert_text "Euro exchange rate was successfully updated"
    click_on "Back"
  end

  test "destroying a Euro exchange rate" do
    visit euro_exchange_rates_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Euro exchange rate was successfully destroyed"
  end
end
