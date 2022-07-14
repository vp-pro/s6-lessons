CREATE TABLE users
(
    id int NOT NULL,
    chat_name varchar(200),
    registration_ts timestamp(6),
    country varchar(200),
    age float,
    gender varchar(1),
    email varchar(50),
    CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
);