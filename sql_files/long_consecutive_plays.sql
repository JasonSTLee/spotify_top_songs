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

-- Most consecutive replays
with prior_replay as (	
	SELECT 
		track_artists, 
		LAG(track_artists) OVER() as prior_song,
		CASE 
			WHEN track_artists = LAG(track_artists) OVER() THEN 1 
		END as flag,
		endtime,
		msplayed,
		LAG(msplayed) OVER() as prior_msplayed,
		LAG(endtime) OVER() as prior_endtime,
		duration
	FROM
		song_data
	WHERE
		(msplayed / 60000) > 1
), time_difference as (
	SELECT
		track_artists,
		endtime,
		prior_endtime,
		duration / 60000 as duration_minutes,
		EXTRACT(epoch FROM endtime - prior_endtime) / 60 as diff_minutes,
		msplayed / 60000 as played_minutes
	FROM
		prior_replay
	WHERE
		flag = 1
)
SELECT
	track_artists, COUNT(*) as consecutive_plays
FROM	
	time_difference
WHERE
	diff_minutes <= duration_minutes 
	and
	(played_minutes / duration_minutes) >= .5
GROUP BY
	track_artists
ORDER BY
	consecutive_plays DESC