DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS houses;

CREATE TABLE houses(
  id serial4 PRIMARY KEY,
  name VARCHAR(255)
);


CREATE TABLE students(
  id serial4 PRIMARY KEY,
  first_name VARCHAR(255),
  last_name VARCHAR(255),
  age INT2,
  house VARCHAR(255),
  house_id INT4 REFERENCES houses(id)
);
