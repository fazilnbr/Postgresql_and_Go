            -- !delete if any table named class_A

DROP TABLE IF EXISTS class_A;

--  output=> 

--        DROP TABLE


------------------------------------------------------------------------


            -- !creating table named class_A 

CREATE TABLE class_A(
    id serial PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mark INT,
    created_at timestamp(0) NOT NULL DEFAULT NOW() 
);


--  output=> 

--      CREATE TABLE


------------------------------------------------------------------------


            -- !inserting values to the table

INSERT INTO class_A (name,mark) VALUES ('FAZIL',56);
INSERT INTO class_A (name,mark) VALUES ('SETHU',86);
INSERT INTO class_A (name,mark) VALUES ('PRASHANTH',76);
INSERT INTO class_A (name,mark) VALUES ('AJAL',80);
INSERT INTO class_A (name,mark) VALUES ('JASEELA',86);

--  output=> 

--      INSERT 0 1
--      INSERT 0 1
--      INSERT 0 1
--      INSERT 0 1
--      INSERT 0 1


------------------------------------------------------------------------


            -- we could also add value in a single line like this


INSERT INTO class_A (name,mark) VALUES 
('BADUSHA',67),
('INSHAD',83),
('AYYUBI',88),
('SOURAV',85),
('ABIJITH',77),
('ABID',90);

--  output=>

--      INSERT 0 6


------------------------------------------------------------------------


            --last step display the table

SELECT * FROM class_A;

 
--  output=>

--       id |   name    | mark |     created_at      
--      ----+-----------+------+---------------------
--        1 | FAZIL     |   56 | 2022-11-24 10:55:51
--        2 | SETHU     |   86 | 2022-11-24 10:55:51
--        3 | PRASHANTH |   76 | 2022-11-24 10:55:51
--        4 | AJAL      |   80 | 2022-11-24 10:55:51
--        5 | JASEELA   |   86 | 2022-11-24 10:55:51
--        6 | BADUSHA   |   67 | 2022-11-24 10:55:51
--        7 | INSHAD    |   83 | 2022-11-24 10:55:51
--        8 | AYYUBI    |   88 | 2022-11-24 10:55:51
--        9 | SOURAV    |   85 | 2022-11-24 10:55:51
--       10 | ABIJITH   |   77 | 2022-11-24 10:55:51
--       11 | ABID      |   90 | 2022-11-24 10:55:51
--      (11 rows)


------------------------------------------------------------------------

            --display detials of students getting mark greater than 80

SELECT * FROM class_A WHERE mark > 80;

--  output=>

--       id |  name   | mark |     created_at      
--      ----+---------+------+---------------------
--        2 | SETHU   |   86 | 2022-11-24 12:44:18
--        5 | JASEELA |   86 | 2022-11-24 12:44:18
--        7 | INSHAD  |   83 | 2022-11-24 12:44:18
--        8 | AYYUBI  |   88 | 2022-11-24 12:44:18
--        9 | SOURAV  |   85 | 2022-11-24 12:44:18
--       11 | ABID    |   90 | 2022-11-24 12:44:18
--      (6 rows)




------------------------------------------------------------------------