-- this for the sql and Go connections

-- drop table if exist
DROP TABLE IF EXISTS user;

-- create a table

CREATE TABLE user(
    id serial PRIMARY KEY,
    usr_name VARCHAR(100) NOT NULL,
    usr_pwd VARCHAR(100) NOT NULL,
    created_at timestamp(0) NOT NULL DEFAULT NOW() 
);

-- inserting one row 
INSERT INTO user (usr_name,usr_pwd) VALUES ('FASIL','12345');