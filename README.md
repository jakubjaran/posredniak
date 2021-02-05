# posredniak

It's my **flutter** app for displaying job offers provided by my **job_scraper**.

It parse data from **mongoDB** with the help of **mongo_dart**.

In app you can save job offers you are interested to, and also you can apply keywords to show only certain offers.

It's very comfortable to have job offers from multiple sites in one place.

That app is in polish language, but it's simple to translate it to your language.


## How to use it with your own job offers?

If you want to use it check **'/lib/models/offer.dart'** file to get to know how job offers are structured.

Then provide mongoDB url in **'/lib/SECRET.dart'** file as:

    const MONGO_URL = 'your_mongo_db_url'

and make some changes in **'/lib/main.dart'** to match your DB.

Also there check how keywords work. They also use your DB.
