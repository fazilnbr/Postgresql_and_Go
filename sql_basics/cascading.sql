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

-- !delete if any table named address

    DROP TABLE IF EXISTS address;

--  output=> 

--        DROP TABLE


------------------------------------------------------------------------



-- !creating child table of student named address hear the student_id is the maching of id on the student table 

CREATE TABLE address(
    id serial PRIMARY KEY,
    address VARCHAR(100) NOT NULL,
    student_id int REFERENCES student(id) ON DELETE CASCADE --forin key from primary key from student table
);



--      CREATE TABLE

------------------------------------------------------------------------


            -- we could also add value in a single line like this


INSERT INTO address (address,student_id) VALUES 
('NILAMBUR',1),
('KOCHI',1),
('PALAKKAD',2),
('CALICUT',3),
('TVM',3),
('KANNUR',4);

--  output=>

--      INSERT 0 6


------------------------------------------------------------------------


--          !display the table 

SELECT * FROM address;

--      INSERT 0 6
--       id | address  | student_id 
--      ----+----------+------------
--        1 | NILAMBUR |          1
--        2 | KOCHI    |          1
--        3 | PALAKKAD |          2
--        4 | CALICUT  |          3
--        5 | TVM      |          3
--        6 | KANNUR   |          4
--      (6 rows)




------------------------------------------------------------------------

--          !inner joining to tables 

SELECT S.id,S.name,S.place,S.mark,A.address,A.student_id FROM student AS S FULL OUTER JOIN address AS A ON S.id=A.student_id;

--       id |   name    |  place   | mark | address  | student_id 
--      ----+-----------+----------+------+----------+------------
--        1 | fazil     | nilambur |   67 | NILAMBUR |          1
--        1 | fazil     | nilambur |   67 | KOCHI    |          1
--        2 | sethu     | idukki   |   89 | PALAKKAD |          2
--        3 | prashanth | palakkad |   87 | CALICUT  |          3
--        3 | prashanth | palakkad |   87 | TVM      |          3
--        4 | ajal      | trichur  |   98 | KANNUR   |          4
--      (6 rows)

------------------------------------------------------------------------