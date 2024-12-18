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

-- Longest listening streak in days
with song_dates as (
    SELECT
        track_artists,
        endtime::date AS date
    FROM
        song_data
    GROUP BY
        track_artists,
        endtime::date
), numbered_dates as (
    SELECT
        track_artists,
        date,
        ROW_NUMBER() OVER (PARTITION BY track_artists ORDER BY date) as row_num
    FROM
        song_dates
), streak_groups as (
    SELECT
        track_artists,
        date,
        date - (row_num || ' days')::interval as flag
    FROM
        numbered_dates
), streaks as (
	SELECT
	    track_artists,
	    COUNT(*) as streak_length
	FROM
	    streak_groups
	GROUP BY
	    track_artists,
	    flag
)
SELECT 
	track_artists, MAX(streak_length) as longest_streak
FROM
	streaks
GROUP BY
	track_artists
ORDER BY 
	longest_streak DESC