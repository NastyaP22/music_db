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

INSERT INTO singers(name)
VALUES('Баста'), ('Земфира'), ('Сергей Лазарев'), ('Billy Milligan');

INSERT INTO genres(name)
VALUES ('рэп'), ('рок'), ('поп');

INSERT INTO collections(name, year_of_release)
VALUES('Биллитристика', 2020);

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
VALUES ('Руки в потолок', 247, 1);

INSERT INTO songs(name, duration, album_id)
VALUES ('Music Under My Skin', 191, 5);

INSERT INTO songs(name, duration, album_id)
VALUES ('Какаду', 300, 4);

INSERT INTO songs(name, duration, album_id)
VALUES ('Этим летом', 189, 3);

INSERT INTO songs(name, duration, album_id)
VALUES ('Найди меня', 212, 2);

INSERT INTO songs(name, duration, album_id)
VALUES ('Alarm', 219, 2);
