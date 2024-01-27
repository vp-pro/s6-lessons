DROP TABLE IF EXISTS STV2023121113__STAGING.dialogs;
DROP TABLE IF EXISTS STV2023121113__STAGING.groups;
DROP TABLE IF EXISTS STV2023121113__STAGING.users;


CREATE TABLE STV2023121113__STAGING.users (
    id INT PRIMARY KEY,
    chat_name VARCHAR(200),
    registration_dt timestamp,
    country VARCHAR(200),
    age INT CHECK (age >= 0),
    CONSTRAINT users_chat_name_length CHECK (LENGTH(chat_name) <= 200),
    CONSTRAINT users_country_length CHECK (LENGTH(country) <= 200)
) ORDER BY id
SEGMENTED BY HASH(id) ALL NODES;



CREATE TABLE STV2023121113__STAGING.groups (
    id INT PRIMARY KEY,
    admin_id INT,
    group_name VARCHAR(100),
    registration_dt timestamp,
    is_private BOOLEAN,
    CONSTRAINT groups_group_name_length CHECK (LENGTH(group_name) <= 100),
    CONSTRAINT groups_fk_admin FOREIGN KEY (admin_id) REFERENCES STV2023121113__STAGING.users(id)
) ORDER BY id, admin_id
PARTITION BY registration_dt::date
GROUP BY calendar_hierarchy_day(registration_dt::date, 3, 2);


CREATE TABLE STV2023121113__STAGING.dialogs (
    message_id INT PRIMARY KEY,
    message_ts TIMESTAMP,
    message_from INT,
    message_to INT,
    message VARCHAR(1000),
    message_group INT,
    CONSTRAINT dialogs_message_length CHECK (LENGTH(message) <= 1000)
) ORDER BY message_id
SEGMENTED BY HASH(message_id) ALL NODES
PARTITION BY (message_ts::DATE)
GROUP BY calendar_hierarchy_day(message_ts::DATE, 3, 2);






-------------------------------
drop table if exists STV2023121113__STAGING.dialogs;
drop table if exists STV2023121113__STAGING.groups;
drop table if exists STV2023121113__STAGING.users;

create table STV2023121113__STAGING.users
(
    id      int PRIMARY KEY,
    chat_name varchar(200),
    registration_dt datetime,
    country varchar(200),
    age int
)
ORDER BY id
SEGMENTED BY HASH(id) ALL NODES;

create table STV2023121113__STAGING.groups
(
    id      int PRIMARY KEY,
    admin_id int, -- REFERENCE STV2023121113__STAGING.users(id),
    group_name varchar(100),
    registration_dt datetime,
    is_private boolean
)
order by id, admin_id
SEGMENTED BY hash(id) all nodes
PARTITION BY registration_dt::date
GROUP BY calendar_hierarchy_day(registration_dt::date, 3, 2);
;


create table STV2023121113__STAGING.dialogs
(
    message_id   int PRIMARY KEY,
    message_ts   datetime,
    message_from int, -- REFERENCES STV2023121113__STAGING.users(id),
    message_to int, -- REFERENCES STV2023121113__STAGING.users(id),
    message varchar(1000),
    message_group int
)
order by message_id
SEGMENTED BY hash(message_id) all nodes
PARTITION BY message_ts::date
GROUP BY calendar_hierarchy_day(message_ts::date, 3, 2);
;
