# Currency App

## Summary

Fetches currency rates for conversion from EUR to USD and EUR to CHF (both ways). 
Uses `currencylayer` API via the `money-currencylayer-bank` gem, and a PostgreSQL database. 
A simple front end for conversion is presented. Of note is that we want to have the most 
recent rates every morning at 8:00 CET (7:00 UTC).

Deployed here: *https://sleepy-sea-59756.herokuapp.com/*

## Notes on Implementation

#### My Conversion Logic
Due to the API limiting the rate of conversion calls, I wrote my own conversion logic. 
I need multiple conversions due to another limitation in the free tier: USD-based rates 
are the only ones available, and we need EUR-based ones.

#### Time Zone
Uses CET (UTC +1) to the exclusion of CEST.

#### Scheduler
Uses `rufus-scheduler` to set up the scheduled external API call. I use `uptimerobot.com`
to monitor uptime. Whenever the server is running there is exactly one cron job.

#### Accuracy of calculation
The `currencylayer` API provides 6 decimal points of accuracy, which are preserved 
in the database. The second-hand calculations preserve "infinite" precision, while 
presenting rounded figures to the user.

#### Front end calculation
I use JavaScript for the calculation, using rates in the DOM.

## Further development

### Testing
Here are some priorities for test development:

##### Scheduler
Identify the cron job directly and verify it is operational without needing to store
additional information (i.e. `job.txt`). Verify that there is exactly one job this
way. 

##### Database
Try to seed with bad data. Test schema integrity (rejects non-conforming data).

##### Conversion accuracy
Establish the level of accuracy meets certain standards. Possibly converting to
integers outside of database to ensure there are no rounding errors (e.g. instead of
1.093483, use 1093483).

### Possible Additional Features

##### Line graph
I would like to present a line graph for the past weeks of the currency pair selected,
responding to a drop-down menu. I have already seeded the database for this purpose. One possibility 
would be to set up a partial for the chart Look for missing data and automatically get historical 
data to patch dataset, prioritizing recent weeks for the line graph.

##### Security
Make the API key an environment variable.

##### More frequent external API calls
If at some future point we would like to make more than one API call per day, we should 
add a `time` column to the `euro_exchange_rates` table.

##### Re-factoring
Weeding out unnecessary parts of Rails. General tidying up and linting, better naming of variables
and files. Tightening up scopes and interfaces.
