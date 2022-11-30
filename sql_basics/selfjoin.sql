--              This is an sql code and its about the SELFJOIN on the sql
                    -----------------------------------------------
--  self join is joining of same table  it match each row to all rows                     
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

    DROP TABLE IF EXISTS student CASCADE;

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



--      CREATE TABLE

------------------------------------------------------------------------


-- !display the table

SELECT * FROM student;


--       id | name | place | mark | created_at 
--      ----+------+-------+------+------------
--      (0 rows)


------------------------------------------------------------------------

--          !hear we copy text file to the table. text1.txt on the same location

\COPY student (name,place,mark) from 'text1.txt' WITH  DELIMITER ',';


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


--          !here we join student table itself so here  display 4(row) * 4 = 16 rows


SELECT * FROM student AS S1,student AS S2;


--       id |   name    |  place   | mark |     created_at      | id |   name    |  place   | mark |     created_at      
--      ----+-----------+----------+------+---------------------+----+-----------+----------+------+---------------------
--        1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12 |  1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12
--        1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12 |  2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12
--        1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12 |  3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12
--        1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12 |  4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12
--        2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12 |  1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12
--        2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12 |  2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12
--        2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12 |  3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12
--        2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12 |  4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12
--        3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12 |  1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12
--        3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12 |  2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12
--        3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12 |  3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12
--        3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12 |  4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12
--        4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12 |  1 | fazil     | nilambur |   67 | 2022-11-26 10:41:12
--        4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12 |  2 | sethu     | idukki   |   89 | 2022-11-26 10:41:12
--        4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12 |  3 | prashanth | palakkad |   87 | 2022-11-26 10:41:12
--        4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12 |  4 | ajal      | trichur  |   98 | 2022-11-26 10:41:12
--      (16 rows)




------------------------------------------------------------------------



--          !here we join the student table itself name columns


SELECT S1.id,S1.name,S2.name FROM student AS S1,student AS S2;


--       id |   name    |   name    
--      ----+-----------+-----------
--        1 | fazil     | fazil
--        1 | fazil     | sethu
--        1 | fazil     | prashanth
--        1 | fazil     | ajal
--        2 | sethu     | fazil
--        2 | sethu     | sethu
--        2 | sethu     | prashanth
--        2 | sethu     | ajal
--        3 | prashanth | fazil
--        3 | prashanth | sethu
--        3 | prashanth | prashanth
--        3 | prashanth | ajal
--        4 | ajal      | fazil
--        4 | ajal      | sethu
--        4 | ajal      | prashanth
--        4 | ajal      | ajal
--      (16 rows)




------------------------------------------------------------------------

--          !in selfjoin we could compare same columns in same table

SELECT S1.id,S1.name,S2.name FROM student AS S1,student AS S2 WHERE S1.name=S2.name;

--       id |   name    |   name    
--      ----+-----------+-----------
--        1 | fazil     | fazil
--        2 | sethu     | sethu
--        3 | prashanth | prashanth
--        4 | ajal      | ajal
--      (4 rows)


------------------------------------------------------------------------
