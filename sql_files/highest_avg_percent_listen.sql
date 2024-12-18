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

-- Least skipped song / Highest average percentage of when the song appears, it is listened
with song_listens as (
	SELECT
		track_artists,
		COUNT(*) as song_listens
	FROM
		song_data
	WHERE
		msplayed / duration >= .5
	GROUP BY
		track_artists
), song_plays as (
	SELECT	
		track_artists,
		COUNT(*) as song_plays
	FROM
		song_data
	GROUP BY
		track_artists
)
SELECT
	p.track_artists, ROUND(((l.song_listens::numeric / p.song_plays::numeric) * 100), 2) percentage_listened
FROM
	song_plays p
JOIN
	song_listens l ON p.track_artists = l.track_artists
ORDER BY	
	percentage_listened DESC