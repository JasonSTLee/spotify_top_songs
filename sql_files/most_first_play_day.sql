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

-- Most plays when the song was the first track of the day
with song_rnks as (	
	SELECT
		track_artists,
		ROW_NUMBER() 
			OVER(PARTITION BY 
					(endtime AT TIME ZONE 'UTC' AT TIME ZONE 'PST')::date 
				 ORDER BY 
					(endtime AT TIME ZONE 'UTC' AT TIME ZONE 'PST')::date) rnk
	FROM
		song_data
	WHERE
		msplayed > 90000
)
SELECT
	track_artists,
	COUNT(*) most_first_plays
FROM
	song_rnks
WHERE
	rnk = 1
GROUP BY
	track_artists
ORDER BY 
	most_first_plays DESC