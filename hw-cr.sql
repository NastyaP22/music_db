CREATE TABLE IF NOT EXISTS singers (
  singer_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres (
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS singers_genres(
  singer_genre_id SERIAL PRIMARY KEY,
  singer_id INTEGER NOT NULL REFERENCES singers(singer_id),
  genre_id INTEGER NOT NULL REFERENCES genres(genre_id)
);

CREATE TABLE IF NOT EXISTS albums(
  album_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  year_of_release INTEGER NOT NULL CHECK(year_of_release >= 1950)
);

CREATE TABLE IF NOT EXISTS singers_albums(
  singer_album_id SERIAL PRIMARY KEY,
  singer_id INTEGER NOT NULL REFERENCES singers(singer_id),
  album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS songs(
  song_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  duration INTEGER NOT NULL,
  album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS collections(
  collection_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  year_of_release INTEGER NOT NULL CHECK(year_of_release >= 1950)
);

CREATE TABLE IF NOT EXISTS songs_collections(
  song_collection_id SERIAL PRIMARY KEY,
  song_id INTEGER NOT NULL REFERENCES songs(song_id),
  collection_id INTEGER NOT NULL REFERENCES collections(collection_id)
);

# 1 задание

INSERT INTO singers(name)
VALUES ('Баста'), ('Земфира'), ('Сергей Лазарев'), ('Billy Milligan');

INSERT INTO genres(name)
VALUES ('рэп'), ('рок'), ('поп');

INSERT INTO collections(name, year_of_release)
VALUES ('Биллитристика', 2020);

INSERT INTO collections(name, year_of_release)
VALUES ('The Best', 2015);

INSERT INTO collections(name, year_of_release)
VALUES ('Спасибо, Вендетта', 2007);

INSERT INTO collections(name, year_of_release)
VALUES ('Баста+', 2013);

INSERT INTO albums(name, year_of_release)
VALUES ('Futurama', 2014);

INSERT INTO albums(name, year_of_release)
VALUES ('Electric touch', 2010);

INSERT INTO albums(name, year_of_release)
VALUES ('Бордерлайн', 2020);

INSERT INTO albums(name, year_of_release)
VALUES ('Папа на рэйве', 2019);

INSERT INTO albums(name, year_of_release)
VALUES ('TV show', 2007);

INSERT INTO songs(name, duration, album_id)
VALUES ('Руки в потолок', 244, 1);

INSERT INTO songs(name, duration, album_id)
VALUES ('Alarm', 221, 2);

INSERT INTO songs(name, duration, album_id)
VALUES ('Music Under My Skin', 191, 5);

INSERT INTO songs(name, duration, album_id)
VALUES ('Этим летом', 189, 3);

INSERT INTO songs(name, duration, album_id)
VALUES ('Какаду', 300, 4);

INSERT INTO songs(name, duration, album_id)
VALUES ('Dislike', 200, 1);

INSERT INTO songs_collections(song_id, collection_id)
VALUES (1, 1);

INSERT INTO songs_collections(song_id, collection_id)
VALUES (2, 3);

INSERT INTO songs_collections(song_id, collection_id)
VALUES(4, 4);

INSERT INTO songs_collections(song_id, collection_id)
VALUES(5, 5);

INSERT INTO singers_genres(singer_id, genre_id)
VALUES (1, 1);

INSERT INTO singers_genres(singer_id, genre_id)
VALUES (1, 2);

INSERT INTO singers_genres(singer_id, genre_id)
VALUES (2, 2);

INSERT INTO singers_genres(singer_id, genre_id)
VALUES (3, 3);

INSERT INTO singers_genres(singer_id, genre_id)
VALUES (4, 1);

INSERT INTO singers_albums(singer_id, album_id)
VALUES (1, 4);

INSERT INTO singers_albums(singer_id, album_id)
VALUES (2, 3);

INSERT INTO singers_albums(singer_id, album_id)
VALUES (3, 2);

INSERT INTO singers_albums(singer_id, album_id)
VALUES (3, 5);

INSERT INTO singers_albums(singer_id, album_id)
VALUES (4, 1);

# 2 задание

SELECT name, duration FROM songs
ORDER BY duration DESC
LIMIT 1;

SELECT name FROM songs
WHERE duration >= 210;

SELECT name FROM collections
WHERE year_of_release > 2017 AND year_of_release < 2021;

SELECT name FROM singers
WHERE LENGTH(name) - LENGTH(replace(name, ' ', '')) = 0

SELECT name FROM songs
WHERE name ILIKE 'my %'
OR name ILIKE '% my %'
OR name ILIKE '% my'
OR name ILIKE 'my'
OR name ILIKE 'мой %'
OR name ILIKE '% мой %'
OR name ILIKE '% мой'
OR name ILIKE 'мой';

# 3 задание

SELECT genres.name, COUNT(singer_id) FROM genres
LEFT JOIN singers_genres ON genres.genre_id = singers_genres.genre_id
GROUP BY genres.genre_id;

SELECT COUNT(song_id) FROM songs
JOIN albums ON songs.album_id = albums.album_id
WHERE year_of_release > 2018 AND year_of_release < 2021;

SELECT albums.name, AVG(duration) FROM songs
JOIN albums ON songs.album_id = albums.album_id
GROUP BY albums.album_id;

SELECT DISTINCT singers.name FROM singers
JOIN singers_albums ON singers.singer_id = singers_albums.singer_id
JOIN albums ON singers_albums.album_id = albums.album_id
WHERE singers.name <>
(SELECT singers.name FROM singers
JOIN singers_albums ON singers.singer_id = singers_albums.singer_id
JOIN albums ON singers_albums.album_id = albums.album_id WHERE year_of_release = 2020);

SELECT DISTINCT collections.name FROM collections
JOIN songs_collections ON collections.collection_id = songs_collections.collection_id
JOIN songs ON songs_collections.song_id = songs.song_id
JOIN singers_albums ON songs.album_id = singers_albums.album_id
JOIN singers ON singers_albums.singer_id = singers.singer_id
WHERE singers.name = 'Баста';

# 4 задание

SELECT albums.name FROM albums
JOIN singers_albums ON albums.album_id = singers_albums.album_id 
WHERE singers_albums.singer_id = (SELECT singers.singer_id FROM singers
JOIN singers_genres ON singers.singer_id = singers_genres.singer_id 
GROUP BY singers.singer_id 
HAVING COUNT(singers_genres.singer_id) > 1);

SELECT singers.name FROM singers
JOIN singers_albums ON singers.singer_id = singers_albums.singer_id
JOIN songs ON songs.album_id = singers_albums.album_id 
WHERE songs.duration = (SELECT MIN(duration) FROM songs
JOIN albums ON songs.album_id = albums.album_id);

SELECT songs.name FROM songs
LEFT JOIN songs_collections ON songs.song_id = songs_collections.song_id
WHERE songs_collections.song_id is NULL

SELECT albums.name FROM albums
JOIN songs ON albums.album_id = songs.album_id
GROUP BY albums.album_id
HAVING COUNT(song_id) = (SELECT COUNT(song_id) FROM songs
GROUP BY album_id
ORDER BY 1
LIMIT 1)