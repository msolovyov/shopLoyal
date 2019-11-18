# shopLoyal
shopify loyalty integration app showcase

This app will allow the store owner to set up a multiplier for every dollar spent by the customer. This in turn will track points per customer and send them an email after every order. 

setup: 

put your api keys in .env or in your environment variables.

Format:
SHOPIFY_API_KEY=XXXXXXXXX
SHOPIFY_API_SECRET=YYYYYYYYY

config/application.rb has the app host url. Put the ngrok or running servers public url here. 

Project Details

    Your job is to create a simple loyalty program private app for Shopify using the Shopify API, Ruby on Rails and a database of your choice.
      
    Merchants can install the app from your application (even though it won't be listed on the app store), then specify the # of points a customer can earn per $ dollar spent. 
    After this has been set any customer that places an order will earn points. 
    For example, if the merchant sets the number of points per dollar spent value to 10, then a customer places an order for $20, then the customer will earn 10 x 20 = 200 points.  
    Use the order webhook to receive order events and process the webhook in a background worker.
     
    The only way customers need to know their balance is through an email which they will receive from the loyalty program app after each order. 
    The email will say something like "You earned 123 points on your last order. You now have a balance of 5000 points".  Send this email asynchronously.
     
    After a merchant installs the app they should be able to log into the app again from their Shopify dashboard and:

        Update the # of points per dollar spent 
        View a grid of each customer's points balance (for any that placed orders, no need to sync history or show old points balances). 
        Each row should show customer name, customer email, and points balance.


