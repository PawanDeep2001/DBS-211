-- ***********************
-- Name: Pawan Deep
-- ID: 111144218
-- Date: 02-16-2022
-- Purpose: Lab 05 DBS211
-- ***********************

-- Q1a SOLUTION --

CREATE TABLE l5_movies(
m_id            NUMBER      PRIMARY KEY,
title           VARCHAR2(35)NOT NULL        UNIQUE,
release_year    NUMBER      NOT NULL,
director_id     NUMBER      NOT NULL,
score           NUMBER(3,2) DEFAULT 2.5     CHECK(score BETWEEN 1 AND 4));

-- Q1b SOLUTION --

CREATE TABLE l5_actors(
a_id            NUMBER      PRIMARY KEY,
first_name      VARCHAR2(20)NOT NULL,
last_name       VARCHAR2(30)NOT NULL);

-- Q1c SOLUTION --

CREATE TABLE l5_casting(
movie_id        NUMBER      REFERENCES l5_movies(m_id) ON DELETE CASCADE,
actor_id        NUMBER      REFERENCES l5_actors(a_id),
PRIMARY KEY(movie_id, actor_id));

-- Q1d SOLUTION --

CREATE TABLE l5_directors(
director_id     NUMBER      PRIMARY KEY,
first_name      VARCHAR2(20)NOT NULL,
last_name       VARCHAR2(30)NOT NULL);

-- Q2 SOLUTION --

ALTER TABLE l5_movies
ADD CONSTRAINT director_id_fk
FOREIGN KEY (director_id)
REFERENCES l5_directors(director_id)
ON DELETE CASCADE;

-- Q3 SOLUTION --

TRUNCATE TABLE l5_directors CASCADE;

-- Q4a SOLUTION --

DROP TABLE l5_casting;
DROP TABLE l5_actors;
DROP TABLE l5_movies;
DROP TABLE l5_directors;

-- Q4b SOLUTION --
-- yes, the order in which we delete the tables has to be correct, because we can't delete tables that have their primary key referenced by other tables foreign key
-- for example we have to delete l5_casting before l5_actors and l5_movies because l5_casting has the primary keys of the other 2 tables. For the same reasons 
-- l5_movies needs to be deleted before l5_directors.


