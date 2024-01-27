ALTER TABLE STUDENT_SCHEMA.BAD_IDEA SET MERGEOUT 1;

CREATE TABLE members
(
    id int NOT NULL,
    age int,
    gender char,
    email varchar(50),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);


COPY STV2023121113.members ( id, age, gender, email  ENFORCELENGTH )
FROM LOCAL 'C:\Users\Vladislav\Downloads\members.csv'
DELIMITER ';'
REJECTED DATA AS TABLE STV2023121113.members_rej
; 