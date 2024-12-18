# 🎼 Spotify Top Songs

Spotify's annual "Wrapped" feature showcases users' top songs, albums, and artists based on their listening data. However, many users — myself included — often find that these "top songs" don't truly reflect how we feel about our favorite songs. To tackle this, I've created a project that explores alternative ways to define 'top songs'. By creating different metrics like listening streaks, replay frequency, completion rates and more; this project offers multiple perspectives on your most-played tracks.

To get the data from your Spotify account (works with premium and free accounts) click the link [here](https://www.spotify.com/uk/account/privacy/). After up to 5 business days Spotify will email you a zip file of jsons containting streaming history, payment information, search queries and more. 

Getting my user data required using [Spotify's api](https://developer.spotify.com/documentation/web-api) with the [Spotify wrapper](https://spotipy.readthedocs.io/en/2.19.0/#). The Jupyter notebook has outlined ways to use the Spotipy wrapper to retrieve user track data, and turning the Spotify json files to csv then importing to Postgresql for further analysis. 

**Tech used:** Python (libraries include Pandas, Spotipy, Spotify), Postgresql, Tableau

## Metric 1)
