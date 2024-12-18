CREATE TEMP TABLE song_data as (
	SELECT 
		trackname, 
		artists, 
		trackname || ' by ' || ARRAY_TO_STRING(artists, ' and ') as track_artists, 
		endtime, 
		starttime, 
		msplayed,
		duration, 
		added_at, 
		album
	FROM
		streaming_hist s
	INNER JOIN
		liked_songs l ON s.artistname && l.artists AND s.trackname = l.name
)

-- Most minutes played per day since the song was added
with minutes_listened as (
	SELECT
		track_artists,
		(SUM(msplayed) / 60000) as minutes_played
	FROM
		song_data
	GROUP BY
		track_artists
), days_liked as (
	SELECT
		track_artists,
		(SELECT MAX(endtime::date) FROM song_data) - MIN(added_at::date) as days_liked
	FROM	
		song_data
	GROUP BY
		track_artists
)
SELECT
	m.track_artists, minutes_played / days_liked as minutes_per_day
FROM
	minutes_listened m 
JOIN
	days_liked d ON m.track_artists = d.track_artists
ORDER BY
	minutes_per_day DESC