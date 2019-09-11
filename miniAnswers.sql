--FOREIGN KEYS - NEW TABLE
--When creating tables we can specify a column as having a foreign key. 
--The datatype of our column must match the datatype of the column we 
--are linking to. The most common foriegn key is a primary key which is
--usually an integer.

--Create a new table called movie with a movie_id, title, and media_type_id.
    --Make media_type_id a foreign key to the media_type_id column on the 
    --media_type table.
--1. 
CREATE TABLE movie (
movie_id SERIAL,
title TEXT NOT NULL,
media_type_id INT NOT NULL,
FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id)
);

--Add a new entry into the movie table with a title and media_type_id.
--2.
INSERT INTO movie
(title, media_type_id)
VALUES
('Toy Story', 3);

--Query the movie table to get your entry.
--3.
SELECT * FROM movie;

--FOREIGN KEYS - EXISTING TABLE
--We can also add a foreign key to an existing table. Let's add one to our
    --movie table that references genre_id on the genre table.

--Add a new column called genre_id that references genre_id on the genre table.
--1.
ALTER TABLE movie
ADD COLUMN genre_id INT REFERENCES genre(genre_id);

--Query the movie table to see your entry.
--2.
SELECT * FROM movie;

--UPDATING ROWS
--We don't want to leave the genre_id equal to null so let's add a value 
    --using the update command. With an update command you always want to use 
    --a WHERE clause. If you don't you will overwrite data on all records.

--Update the first entry in the movie table to a genre_id of 22.
--1.
UPDATE movie
SET genre_id = 22
WHERE movie_id = 1;

--Query the movie table to see your entry.
--2.
SELECT * FROM movie;

--USING JOINS
--Now that we know how to make foreign keys and change data, let's do some 
    --practice queries. The simplest way to use a foreign key is via a join statement.

--Join the artist and album tables to list out the artist name and album name.
--1.
SELECT al.title, ar.name
FROM album al
INNER JOIN artist ar
ON al.artist_id = ar.artist_id;

--USING NESTED QUERIES/SUB-SELECTS
--The next way to use a primary key is with a nested query/sub-select statement. 
    --By using parenthesis we can do a select inside of a select. This is really effective 
    --when you have a foreign key link between two tables because now we can filter our 
    --main query by criteria on a referenced table.

--Use a sub-select statement to get all tracks from the Track table where the genre_id 
--is either Jazz or Blues.
--1.
SELECT * FROM track
WHERE genre_id IN 
(SELECT genre_id FROM genre
WHERE name = 'Jazz'
OR name = 'Blues');

--SETTING VALUES to NULL

--Update Phone on the Employee table to null where the EmployeeId is 1.
--1.
UPDATE employee
SET phone = NULL
WHERE employee_id = 1;

--Query the Employee table to get the employee you just updated.
--2.
SELECT * FROM employee
WHERE employee_id = 1;

--QUERYING A NULL VALUE
--Sometimes you want to know when there is no value. For example, let's 
    --use the customer table to figure out which customers do not have a company.

--Get all customers from the customer table who do not have a company.
--1.
SELECT * FROM customer
WHERE company IS NULL;

--GROUP BY
--How many albums does each artist have? We could count manually, but no! 
    --Group by allows us to do aggregate counts.

--Select all artist ids, artist names, and count how many albums they have.
--1.
SELECT ar.artist_id, ar.name, count(*)
FROM artist ar
INNER JOIN album al
ON ar.artist_id = al.artist_id
GROUP BY ar.artist_id;

--DISTINCT
--Distinct is great if you want to get a dataset with no duplicates.

--Get all countries from the customer table with no duplicates.
--1.
SELECT DISTINCT COUNTRY FROM customer;

--DELETE ROWS
--Deleting rows can be dangerous if you are not cautious. Always do a select of 
    --what you plan to delete to make sure that you are going to delete the correct records.

--Select all records from the customer table where fax is null;
--1.

--Delete all records from the customer table where fax is null;
--2.
DELETE FROM customer
WHERE fax IS NULL;
--The delete won't work since they are children using a foreign key. However, if there 
    --wasn't a foreign key, you would successfully delete all customers WHERE fax is null