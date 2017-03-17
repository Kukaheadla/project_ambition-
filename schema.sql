CREATE TABLE goals(
  id SERIAL4 PRIMARY KEY,
  ambition TEXT,
  image_url TEXT,
  user_id INTEGER,
  duedate TIMESTAMP,
  status BOOLEAN
);

CREATE TABLE users (
  id SERIAL4 PRIMARY KEY,
  email VARCHAR(400) NOT NULL,
  password_digest VARCHAR(400) NOT NULL,
  username VARCHAR(400)
);

CREATE TABLE comments (
  id SERIAL4 PRIMARY KEY,
  body TEXT,
  goal_id INTEGER,
  user_id INTEGER
);
