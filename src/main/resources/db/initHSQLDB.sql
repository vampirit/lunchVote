DROP TABLE IF EXISTS vote;
DROP TABLE IF EXISTS lunch;
DROP TABLE IF EXISTS restaurant;
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS users;
DROP SEQUENCE IF EXISTS global_seq;

CREATE SEQUENCE GLOBAL_SEQ AS INTEGER START WITH 100000;

CREATE TABLE users
(
  id               INTEGER GENERATED BY DEFAULT AS SEQUENCE GLOBAL_SEQ PRIMARY KEY,
  name             VARCHAR(255)                 NOT NULL,
  email            VARCHAR(255)                 NOT NULL,
  password         VARCHAR(255)                 NOT NULL,
  registered       TIMESTAMP DEFAULT now() NOT NULL,
  enabled          BOOLEAN  DEFAULT TRUE        NOT NULL
);

CREATE UNIQUE INDEX users_unique_email_idx ON users (email);

CREATE TABLE user_roles
(
  user_id INTEGER NOT NULL,
  role    VARCHAR(255),
  CONSTRAINT user_roles_idx UNIQUE (user_id, role),
  FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE restaurant
(
  id            INTEGER GENERATED BY DEFAULT AS SEQUENCE GLOBAL_SEQ PRIMARY KEY,
  name          VARCHAR(255)     NOT NULL,
  address       VARCHAR(255)     NOT NULL,
  CONSTRAINT restaurant_idx UNIQUE ( name, address)
);

CREATE TABLE lunch
(
  id            INTEGER GENERATED BY DEFAULT AS SEQUENCE GLOBAL_SEQ PRIMARY KEY,
  date          DATE DEFAULT now()      NOT NULL,
  description   VARCHAR(255)            NOT NULL,
  price         INTEGER                 NOT NULL,
  restaurant_id INTEGER                 NOT NULL,
  CONSTRAINT lunch_idx UNIQUE ( description, restaurant_id),
  FOREIGN KEY (restaurant_id) REFERENCES restaurant(id) ON DELETE CASCADE
);


CREATE TABLE vote
(
  id               INTEGER IDENTITY PRIMARY KEY,
  user_id          INTEGER    NOT NULL,
  lunch_id         INTEGER    NOT NULL,
  date             DATE DEFAULT now() NOT NULL,

  CONSTRAINT vote_idx UNIQUE (user_id, lunch_id, date),
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (lunch_id) REFERENCES lunch(id) ON DELETE CASCADE
);