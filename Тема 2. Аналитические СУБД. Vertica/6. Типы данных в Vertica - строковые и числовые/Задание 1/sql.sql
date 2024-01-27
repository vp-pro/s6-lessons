CREATE TABLE members
(
    id int NOT NULL,
    age int,
    gender char,
    email varchar(50),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);

CREATE TABLE members_v2
(
    id varchar(2000) NOT NULL,
        age varchar(2000),
    gender varchar(2000),
    email varchar(2000),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);


insert into members_v2
select * from members;
