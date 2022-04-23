class CreateEuroExchangeRates < ActiveRecord::Migration[6.1]
  def change
    create_table :euro_exchange_rates do |t|
      t.date :exchange_date
      t.string :currency_pair, limit: 6
      t.decimal :exchange_rate, precision: 10, scale: 6

      t.timestamps
    end
  end
end
