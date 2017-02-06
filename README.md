# A kitten knows about movies

The app uses the [OMDb API](http://www.omdbapi.com/) to retrieve movie data.


## APIs

1. Search by keyword: https://www.omdbapi.com/?s=[keyword]&page=1

2. Movie data by IMDB id: http://www.omdbapi.com/?i=[IMDBid]&plot=full&r=json

## Usage

Click the cat, it will pick up some movies for you to watch on a lonely and boring Saturday night by performing a search with a randomized keyword. You're trying the app out because you don't have friends.

## Issues:

OMDB is a great set of APIs, but unfortunately it is a bit unstable, probably due to DDoS attacks that it is suffering from. Highly possibly when you try out the app the cat is unable to retrieve any data. I recommend you to try it out during American night time (European day time). If there's no data, don't blame me. Nonetheless, you can take a look at my code.

Though once it has retrieved some data, the data will be cached and next time on the same device you'll get the results faster.

The search keywords are not really randomized, you know. 🐈
