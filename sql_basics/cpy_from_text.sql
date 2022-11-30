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
    mark INT,
    created_at timestamp(0) NOT NULL DEFAULT NOW() 
);


--  output=> 

--      CREATE TABLE

------------------------------------------------------------------------


-- !display the table

SELECT * FROM student;

--  output=> 

--       id | name | place | mark | created_at 
--      ----+------+-------+------+------------
--      (0 rows)


------------------------------------------------------------------------

--          !hear we copy text file to the table. text1.txt on the same location

\COPY student (name,place,mark) from 'text1.txt' WITH  DELIMITER ',';

--  output=> 

--      COPY 4



------------------------------------------------------------------------

--          !display the table after copying

SELECT * FROM student;

--  output=> 

--       id |   name    |  place   | mark |     created_at      
--      ----+-----------+----------+------+---------------------
--        1 | fazil     | nilambur |   67 | 2022-11-24 16:06:11
--        2 | sethu     | idukki   |   89 | 2022-11-24 16:06:11
--        3 | prashanth | palakkad |   87 | 2022-11-24 16:06:11
--        4 | ajal      | trichur  |   98 | 2022-11-24 16:06:11
--      (4 rows)










------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--                  !after running this file on postgres

 --      \i cpy_from_text.sql


--              DROP TABLE

--              CREATE TABLE

--               id | name | place | mark | created_at 
--              ----+------+-------+------+------------
--              (0 rows)
--              
--              COPY 4

--               id |   name    |  place   | mark |     created_at      
--              ----+-----------+----------+------+---------------------
--                1 | fazil     | nilambur |   67 | 2022-11-24 16:13:37
--                2 | sethu     | idukki   |   89 | 2022-11-24 16:13:37
--                3 | prashanth | palakkad |   87 | 2022-11-24 16:13:37
--                4 | ajal      | trichur  |   98 | 2022-11-24 16:13:37
--              (4 rows)


