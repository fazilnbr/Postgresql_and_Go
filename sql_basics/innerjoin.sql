--              This is an sql code and its about the innerjoin on the sql
                    -----------------------------------------------
--      SYNTAX:-
        -------------------------------------------------------------
--      |                                                           |
--      |    definition of the sql query why we using that query    |
--      |                                                           |
--      |    then the query showed in blue and yello color          |
--      |                                                           |
--      |    then the output of that query                          |
--      |                                                           |
--      -------------------------------------------------------------

-- !delete if any table named student

    DROP TABLE IF EXISTS student;

--  output=> 

--        DROP TABLE


------------------------------------------------------------------------



-- !creating table named student 

CREATE TABLE student(
    id serial PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    place VARCHAR(100) NOT NULL,
    teacher_id INT NOT NULL,
    mark INT,
    created_at timestamp(0) NOT NULL DEFAULT NOW() 
);



--      CREATE TABLE

------------------------------------------------------------------------


-- !display the table

SELECT * FROM student;


--       id | name | place | mark | created_at 
--      ----+------+-------+------+------------
--      (0 rows)


------------------------------------------------------------------------

--          !hear we copy text file to the table. text1.txt on the same location

\COPY student (name,place,teacher_id,mark) from 'text1.txt' WITH  DELIMITER ',';


--      COPY 4

------------------------------------------------------------------------

--          !display the table after copying

SELECT * FROM student;


--       id |   name    |  place   | mark |     created_at      
--      ----+-----------+----------+------+---------------------
--        1 | fazil     | nilambur |   67 | 2022-11-24 16:06:11
--        2 | sethu     | idukki   |   89 | 2022-11-24 16:06:11
--        3 | prashanth | palakkad |   87 | 2022-11-24 16:06:11
--        4 | ajal      | trichur  |   98 | 2022-11-24 16:06:11
--      (4 rows)



------------------------------------------------------------------------


-- !delete if any table named student

    DROP TABLE IF EXISTS address;


--        DROP TABLE


------------------------------------------------------------------------



-- !creating table named address 

CREATE TABLE address(
    id serial PRIMARY KEY,
    teacher VARCHAR(100) NOT NULL
);



--      CREATE TABLE

------------------------------------------------------------------------


-- !display the table

SELECT * FROM address;


--       id | name | place | mark | created_at 
--      ----+------+-------+------+------------
--      (0 rows)


------------------------------------------------------------------------

--          !hear we copy text file to the table. text1.txt on the same location

INSERT INTO address (teacher) VALUES 
('dannie'),
('blassy'),
('aneesha'),
('yen'),
('elna');



--      COPY 4

------------------------------------------------------------------------

--          !display the table after copying

SELECT * FROM address;


--       id |   name    |  place   | mark |     created_at      
--      ----+-----------+----------+------+---------------------
--        1 | fazil     | nilambur |   67 | 2022-11-24 16:06:11
--        2 | sethu     | idukki   |   89 | 2022-11-24 16:06:11
--        3 | prashanth | palakkad |   87 | 2022-11-24 16:06:11
--        4 | ajal      | trichur  |   98 | 2022-11-24 16:06:11
--      (4 rows)


------------------------------------------------------------------------

--          !innerjoining two table 

SELECT * FROM student AS S INNER JOIN address AS A ON S.id=A.id;



--       id |   name    |  place   | mark |     created_at      | id | teacher 
--      ----+-----------+----------+------+---------------------+----+---------
--        1 | fazil     | nilambur |   67 | 2022-11-24 19:38:26 |  1 | dannie
--        2 | sethu     | idukki   |   89 | 2022-11-24 19:38:26 |  2 | blassy
--        3 | prashanth | palakkad |   87 | 2022-11-24 19:38:26 |  3 | aneesha
--        4 | ajal      | trichur  |   98 | 2022-11-24 19:38:26 |  4 | elna
--      (4 rows)

 

------------------------------------------------------------------------

--          !hear we join two table with specific field 


SELECT S.id,S.name,S.place,S.mark,A.teacher FROM student AS S INNER JOIN address AS A ON S.id=A.id;



--       id |   name    |  place   | mark | teacher 
--      ----+-----------+----------+------+---------
--        1 | fazil     | nilambur |   67 | dannie
--        2 | sethu     | idukki   |   89 | blassy
--        3 | prashanth | palakkad |   87 | aneesha
--        4 | ajal      | trichur  |   98 | elna
--      (4 rows)

------------------------------------------------------------------------
--          !hear we join and display full row of the left table and matching right table

SELECT S.id,S.name,S.place,S.mark,A.teacher FROM student AS S LEFT OUTER JOIN address AS A ON S.id=A.id;


--       id |   name    |  place   | mark | teacher 
--      ----+-----------+----------+------+---------
--        1 | fazil     | nilambur |   67 | dannie
--        2 | sethu     | idukki   |   89 | blassy
--        3 | prashanth | palakkad |   87 | aneesha
--        4 | ajal      | trichur  |   98 | yen
--      (4 rows)



------------------------------------------------------------------------

--          !hear we join and display full row of the right table and matching left table

SELECT S.id,S.name,S.place,S.mark,A.teacher FROM student AS S RIGHT OUTER JOIN address AS A ON S.id=A.id;


--       id |   name    |  place   | mark | teacher 
--      ----+-----------+----------+------+---------
--        1 | fazil     | nilambur |   67 | dannie
--        2 | sethu     | idukki   |   89 | blassy
--        3 | prashanth | palakkad |   87 | aneesha
--        4 | ajal      | trichur  |   98 | yen
--          |           |          |      | elna
--      (5 rows)



------------------------------------------------------------------------

--          !hear we join and display full row of the right table and left table
--           and maching display as same and remining

SELECT S.id,S.name,S.place,S.mark,A.teacher FROM student AS S FULL OUTER JOIN address AS A ON S.id=A.id;


--       id |   name    |  place   | mark | teacher 
--      ----+-----------+----------+------+---------
--        1 | fazil     | nilambur |   67 | dannie
--        2 | sethu     | idukki   |   89 | blassy
--        3 | prashanth | palakkad |   87 | aneesha
--        4 | ajal      | trichur  |   98 | yen
--          |           |          |      | elna


------------------------------------------------------------------------

--          !hear we join and display full row of the unmatching right table and left table


SELECT S.id,S.name,S.place,S.mark,A.teacher FROM student AS S FULL OUTER JOIN address AS A ON S.id=A.id WHERE S.id IS NULL OR A.id IS NULL;


--       id | name | place | mark | teacher 
--      ----+------+-------+------+---------
--          |      |       |      | elna
--      (1 row)



------------------------------------------------------------------------