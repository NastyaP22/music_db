CREATE TABLE IF NOT EXISTS singers (
  singer_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS genres (
  genre_id SERIAL PRIMARY KEY,
  name VARCHAR(40) NOT NULL
);

CREATE TABLE IF NOT EXISTS singers_genres(
  singer_genre_id SERIAL PRIMARY KEY,
  singer_id INTEGER NOT NULL REFERENCES singers(singer_id),
  genre_id INTEGER NOT NULL REFERENCES genres(genre_id)
);

CREATE TABLE IF NOT EXISTS albums(
  album_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  year_of_release INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS singers_albums(
  singer_album_id SERIAL PRIMARY KEY,
  singer_id INTEGER NOT NULL REFERENCES singers(singer_id),
  album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS songs(
  song_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  duration VARCHAR(20) NOT NULL,
  album_id INTEGER NOT NULL REFERENCES albums(album_id)
);

CREATE TABLE IF NOT EXISTS collections(
  collection_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  year_of_release INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS songs_collections(
  song_collection_id SERIAL PRIMARY KEY,
  song_id INTEGER NOT NULL REFERENCES songs(song_id),
  collection_id INTEGER NOT NULL REFERENCES collections(collection_id)
);