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
	

-- Most minutes listened to
SELECT
	track_artists, (SUM(msplayed) / 60000) as minutes_played
FROM
	song_data
GROUP BY
	track_artists
ORDER BY	
	minutes_played DESC
