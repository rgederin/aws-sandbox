CREATE DATABASE AWS_COURSE_DB;

CREATE TABLE AWS_COURSE_TRAINERS (
  TRAINER_ID INTEGER PRIMARY KEY,
  TRAINER_NAME VARCHAR(200)
);

INSERT INTO AWS_COURSE_TRAINERS VALUES (1, 'Alex');
INSERT INTO AWS_COURSE_TRAINERS VALUES (2, 'Vova');

SELECT * FROM AWS_COURSE_TRAINERS;
