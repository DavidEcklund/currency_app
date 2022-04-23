# Currency App

## Summary

Fetches currency rates for conversion from EUR to USD and EUR to CHF (both ways). 
Uses currencylayer API and PostgreSQL database. 
Simple front end for conversion.

## Longer Description

Challenge from here: https://github.com/2wunder/currency-data-challenge
Of note is that we want to have the most recent rates every morning at 8:00 CET.

## Further development
If at some future point we would like to make more than one API call per day, we should add a `time` column 
to the euro_exchange_rates table.