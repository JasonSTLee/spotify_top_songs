# 🎼 Spotify Top Songs

Spotify's annual "Wrapped" feature showcases users' top songs, albums, and artists based on their listening data. However, many users — myself included — often find that these "top songs" don't truly reflect how we feel about our favorite songs. To tackle this, I've created a **project that explores alternative ways to define 'top songs'**. By creating different metrics like listening streaks, replay frequency, completion rates and more; this project offers multiple perspectives on your most-played tracks.

To get the data from your Spotify account (works with premium and free accounts) click the link [here](https://www.spotify.com/uk/account/privacy/). After up to 5 business days Spotify will email you a zip file of jsons containting streaming history, payment information, search queries and more. 

Getting my user data required using [Spotify's api](https://developer.spotify.com/documentation/web-api) with the [Spotify wrapper](https://spotipy.readthedocs.io/en/2.19.0/#). The Jupyter notebook has outlined ways to use the Spotipy wrapper to retrieve user track data, and turning the Spotify json files to csv then importing to Postgresql for further analysis. 

**Tech used:** Python (libraries include Pandas, Spotipy, Spotify), Postgresql, Tableau

## Metric 1) Most Minutes Listened

<img width="680" alt="Screenshot 2024-12-17 at 5 42 22 PM" src="https://github.com/user-attachments/assets/980c0500-69f0-4ca7-b751-d8e79f5cdeea" />

<table>
  <tr>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Pros</strong>
      <ul>
        <li>Reflects overall listening time</li>
        <li>Rewards longer engagement</li>
        <li>Simple and clear metric to understand</li>
      </ul>
    </td>
    <td style="vertical-align: top; width: 50%; padding: 10px;">
      <strong>Cons</strong>
      <ul>
        <li>Bias toward longer songs</li>
        <li>Skewed by passive listening</li>
        <li>Ignores repeat frequency</li>
      </ul>
    </td>
  </tr>
</table>

