--Q1
SELECT LastName, Email
FROM customers

--Q2
SELECT Title, Name
FROM albums NATURAL JOIN artists

--Q3
SELECT State, Count(DISTINCT CustomerId)
FROM customers
WHERE State IS NOT NULL
GROUP BY State
ORDER BY State ASC

--Q4
SELECT State, Count(DISTINCT CustomerId) AS counting
FROM customers
WHERE State IS NOT NULL
GROUP BY State
 HAVING counting > 10;

 --Q5
SELECT Name
FROM artists NATURAL JOIN albums
WHERE Title LIKE "%symphony%"

--Q6
SELECT DISTINCT artists.Name
FROM tracks
JOIN albums ON albums.AlbumId = tracks.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
JOIN playlist_track ON tracks.TrackId = playlist_track.TrackId
JOIN playlists ON playlists.PlaylistId = playlist_track.PlaylistId 
JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
WHERE media_types.Name LIKE "%MPEG%" AND (playlists.Name = "Brazilian Music" OR playlists.Name = "Grunge")

--Q7
SELECT artists.Name, 
       COUNT(CASE WHEN media_types.Name LIKE '%MPEG%' THEN 1 ELSE NULL END) as counting
FROM tracks
JOIN albums ON albums.AlbumId = tracks.AlbumId
JOIN artists ON artists.ArtistId = albums.ArtistId
JOIN media_types ON media_types.MediaTypeId = tracks.MediaTypeId
GROUP BY artists.Name
HAVING counting > 10;

--Q8
SELECT playlists.PlaylistId, playlists.Name, ROUND(SUM(Milliseconds) / 3600000.0, 2) AS hours
FROM playlists
JOIN playlist_track ON playlists.PlaylistId = playlist_track.PlaylistId
JOIN tracks ON tracks.TrackId = playlist_track.TrackId
GROUP BY playlists.PlaylistId
HAVING hours > 2

--Q9 Artists that have released tracks with two or more genres
--Results show 21 artists that have released at least two different genres in their tracks
SELECT artists.Name, COUNT(DISTINCT genres.Name) AS totalGenre
FROM artists
JOIN albums ON artists.ArtistId = albums.ArtistId
JOIN tracks ON albums.AlbumId = tracks.AlbumId 
JOIN genres ON tracks.GenreId = genres.GenreId
GROUP BY artists.ArtistId
HAVING totalGenre >= 2