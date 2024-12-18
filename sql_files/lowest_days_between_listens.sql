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

-- Songs with the shortest gaps between listens (in days)
with song_dates as (
	SELECT
		track_artists, 
		endtime::date as listen_date
	FROM	
		song_data
	GROUP BY
		track_artists, 
		endtime::date
), diff_date as (
	SELECT
		track_artists,
		listen_date,
		LEAD(listen_date) OVER(PARTITION BY track_artists ORDER BY listen_date) as next_listen_date
	FROM
		song_dates
)
SELECT
	track_artists, 
	ROUND(AVG(next_listen_date - listen_date), 2) as avg_days_between_listens
FROM
	diff_date
WHERE
    next_listen_date IS NOT null
GROUP BY
	track_artists
ORDER BY
	avg_days_between_listens