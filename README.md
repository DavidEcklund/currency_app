# Currency App

## Summary

Fetches currency rates for conversion from EUR to USD and EUR to CHF (both ways). 
Uses currencylayer API and PostgreSQL database. 
Simple front end for conversion.

## Longer Description

Challenge from here: https://github.com/2wunder/currency-data-challenge
Of note is that we want to have the most recent rates every morning at 8:00 CET.

## Notes on Implementation

### My Conversion Logic
Due to the API limiting the rate of conversion calls, I wrote my own conversion logic. 
I need multiple conversions due to another limitation in the free tier: USD-based rates 
are the only ones available, and we need EUR-based ones.

### Seed Data
I modified the provided seed data to make it appear to be providing the last two weeks 
of rates, without actually getting them.

## Further development
If at some future point we would like to make more than one API call per day, we should 
add a `time` column to the euro_exchange_rates table.