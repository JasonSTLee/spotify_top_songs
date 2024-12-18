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

-- Songs with highest average listening rate 
SELECT
    track_artists,
	ROUND(AVG(LEAST(msplayed::NUMERIC / duration::NUMERIC, 1)) * 100, 2) as avg_completion_rate
FROM
    song_data
WHERE
    duration > 0 
GROUP BY
    track_artists
ORDER BY
    avg_completion_rate DESC