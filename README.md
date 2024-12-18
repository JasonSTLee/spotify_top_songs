# 🎼 Spotify Top Songs

Spotify's annual "Wrapped" feature showcases users' top songs, albums, and artists based on their listening data. However, many users — myself included — often find that these "top songs" don't truly reflect how we feel about our favorite songs. To tackle this, I've created a **project that explores alternative ways to define 'top songs'**. By creating different metrics like listening streaks, replay frequency, completion rates and more; this project offers multiple perspectives on your most-played tracks.

To get the data from your Spotify account (works with premium and free accounts) click the link [here](https://www.spotify.com/uk/account/privacy/). After up to 5 business days Spotify will email you a zip file of jsons containting streaming history, payment information, search queries and more. 

Getting my user data required using Spotify's api with the Spotify wrapper. The Jupyter notebook has outlined ways to use the Spotipy wrapper to retrieve user track data, and turning the Spotify json files to csv then importing to Postgresql for further analysis. 

**Tech used:** Python (libraries include Pandas, Spotipy, Spotify), Postgresql, Tableau

[**Tableau Dashboard**](https://public.tableau.com/app/profile/jason.lee2654/viz/SpotifyTopSongsDashboard/TopSpotifySongsDashboard))

---

## Metric 1) Most Minutes Listened

Adding up total minutes per track.

<img width="678" alt="Screenshot 2024-12-18 at 2 13 28 PM" src="https://github.com/user-attachments/assets/8c7e8691-9b71-4920-b67d-744d4060a026" />

This metric adds the total minutes listened to per song.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Songs that have been on repeat are highlighted</li>
        <li>Simple and clear metric to understand</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Bias toward longer songs</li>
        <li>Skewed by passive listening</li>
        <li>Doesn't take into account repeat frequency</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 2) Most Minutes Listened per Day Since Added

<img width="694" alt="Screenshot 2024-12-18 at 2 13 47 PM" src="https://github.com/user-attachments/assets/f6800d4e-4ebe-4135-b50b-64f2de568434" />

This metric adds the total minutes listened to divided by the days since adding the song.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Highlights listening consistency over time</li>
        <li>Reduces bias of older songs with more playtime</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Can be skewed towards songs with bouts of high listening frequency</li>
        <li>Assumes consistent interest since date added</li>
        <li>Doesn't distinguish between repeated listening to shorter songs and listening longer songs once</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 3) Longest Consecutive Plays w/o Breaks

<img width="678" alt="Screenshot 2024-12-18 at 2 14 11 PM" src="https://github.com/user-attachments/assets/b0922b90-29ce-4e34-ba73-94a1504ec7de" />

This metric counts the consecutive plays (defined by listening of over 1 minute) of a song without changing songs. 

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Emphasizes emotional or addictive connections to the song</li>
        <li>Reduces bias of older songs with more playtime</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Doesn't capture songs that are frequently replayed across different sessions</li>
        <li>Excludes songs that are listened to intermittently</li>
        <li>Can be influenced by short term obsession</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 4) Longest Consecutive Listens in Days

<img width="694" alt="Screenshot 2024-12-18 at 2 14 32 PM" src="https://github.com/user-attachments/assets/baa875df-2b50-4065-bf1f-164a4e9bd7c8" />

This metric counts the consecutive days a song has been played (defined by listening of over 1 minute).

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Focuses on long-term listening habits</li>
        <li>Highlights songs with lasting appeal over a period of time</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Songs listened to reptitiously within a day is not accounted for</li>
        <li>Missing a day of listening breaks pattern</li>
        <li>Biased for consistency over intensity</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 5) Most First Play of the Day

<img width="696" alt="Screenshot 2024-12-18 at 2 15 15 PM" src="https://github.com/user-attachments/assets/b90d3444-5c25-4cd5-9afa-e3b9bdc74a3e" />

This metric counts how often a song was the first to play (defined by listening of over 1 minute) in the day.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Starting the day off deliberately, instead of passive listening</li>
        <li>Highlight songs that will set the tone for the rest of the day</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Ignores total listening time for much I listen to the song beyond the first play</li>
        <li>Biased towards morning listening habits</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 6) Highest Average Percentage Listened

<img width="704" alt="Screenshot 2024-12-18 at 2 15 37 PM" src="https://github.com/user-attachments/assets/8ce88135-4e7c-4d71-acfb-6d38075ac98f" />

This metric averages the number of times that when a song comes up, it is listened fully.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Reflects songs listened consistently and completely or almost completely</li>
        <li>Highlight songs that aren't skip</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Penalizes songs with long intros or outros</li>
        <li>Songs listened fully once could outrank songs partially listened to multiple times</li>
        <li>Biased towards shorter songs</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 7) Lowest Avg Days Between Listens

<img width="686" alt="Screenshot 2024-12-18 at 2 16 01 PM" src="https://github.com/user-attachments/assets/fb04ae8a-c617-4760-8c7c-73aaf694db4b" />

This metric averages the number of days between ful song listens.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Identifies songs that are listened to frequently over time</li>
        <li>Accounts for songs that are steadily listened to rather short sporadic bursts</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Newer songs may have artificially high gaps if they haven't been saved to my library long</li>
        <li>Misses seasonal songs or songs during specific periods in life</li>
      </ul>
    </td>
  </tr>
</table>

---

## Metric 8) Highest Average Completion Rate

<img width="703" alt="Screenshot 2024-12-18 at 2 16 22 PM" src="https://github.com/user-attachments/assets/66a07f01-6387-4fc8-9745-79da02063aea" />

This metric averages the percentage of how thorough a song is played, accounting for short and full listens. Not to be confused with Metric 6) Highest Average Percentage Listened - that accounts for a song's appearance rather than the song's length.

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Rewards songs that are listened to in full rather than skipped partly through</li>
        <li>Unlike 'total minutes played' this metric focuses on how thoroughly a song is finished rather than how long the song is</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Longer songs or songs with longer intro and outros could be penalized</li>
        <li>Focuses not on how often a song is played but how frequently it is completed</li>
        <li>May skew towards passive listening</li>
      </ul>
    </td>
  </tr>
</table>

---

# Conclusion

What I learned the most was that a simple business metric such as 'Top Songs' can be defined in many ways depending on the user / business goal. Each definition - whether average duration listened, most minutes listened to per day since added, etc - offers a unique lens through which to interpret listening behavior. By diving deeper and augmenting what it means to be a top song, we're able to view different results. Some metrics have overlapping top songs, reinforcing trends and patterns while other metrics show different insights. 

Ultimately there are no absolute right and wrongs. This project was to explore seamingly straight forward data and create different branches of a north star metric.

# References

- [Spotify's api](https://developer.spotify.com/documentation/web-api)
- [Spotipy wrapper](https://spotipy.readthedocs.io/en/2.19.0/#)
- [Pandas](https://pandas.pydata.org/docs/index.html)
- [Psycopg2](https://pypi.org/project/psycopg2/)
- [Glob](https://docs.python.org/3/library/glob.html)
