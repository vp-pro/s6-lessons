--NOT SURE AT ALL


drop table if exists STV2023121113__DWH.s_admins;

create table STV2023121113__DWH.s_admins
(
hk_admin_id bigint not null CONSTRAINT fk_s_admins_l_admins REFERENCES STV2023121113__DWH.l_admins (hk_l_admin_id),
is_admin boolean,
admin_from datetime,
load_dt datetime,
load_src varchar(20)
)
order by load_dt
SEGMENTED BY hk_admin_id all nodes
PARTITION BY load_dt::date
GROUP BY calendar_hierarchy_day(load_dt::date, 3, 2);


INSERT INTO STV2023121113__DWH.s_admins(hk_admin_id, is_admin,admin_from,load_dt,load_src)
select la.hk_l_admin_id,
True as is_admin,
hg.registration_dt,
now() as load_dt,
's3' as load_src
from STV2023121113__DWH.l_admins as la
left join STV2023121113__DWH.h_groups as hg on la.hk_group_id = hg.hk_group_id;




-- s_group_name Satellite Table
DROP TABLE IF EXISTS STV2023121113__DWH.s_group_name;

CREATE TABLE STV2023121113__DWH.s_group_name
(
    hk_group_id INT NOT NULL,
    group_name VARCHAR(100),
    load_dt DATETIME,
    load_src VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

-- Populate s_group_name
INSERT INTO STV2023121113__DWH.s_group_name(hk_group_id, group_name, load_dt, load_src)
SELECT
    sg.id,
    sg.group_name,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.groups AS sg;





---------------------------------

-- s_group_private_status Satellite Table
DROP TABLE IF EXISTS STV2023121113__DWH.s_group_private_status;

CREATE TABLE STV2023121113__DWH.s_group_private_status
(
    hk_group_id INT NOT NULL CONSTRAINT fk_s_group_private_status_l_groups REFERENCES STV2023121113__DWH.h_groups (hk_group_id),
    is_private BOOLEAN,
    load_dt DATETIME,
    load_src VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_group_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

-- Populate s_group_private_status
INSERT INTO STV2023121113__DWH.s_group_private_status(hk_group_id, is_private, load_dt, load_src)
SELECT
    sg.id,
    sg.is_private,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.groups AS sg;


-----------------------------------------

-- s_dialog_info Satellite Table
DROP TABLE IF EXISTS STV2023121113__DWH.s_dialog_info;

CREATE TABLE STV2023121113__DWH.s_dialog_info
(
    hk_message_id INT NOT NULL,
    message VARCHAR(1000),
    message_from INT,
    message_to INT,
    load_dt DATETIME,
    load_src VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_message_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

--CONSTRAINT fk_s_dialog_info_l_user_message REFERENCES STV2023121113__DWH.l_user_message (hk_message_id),
-- Populate s_dialog_info
INSERT INTO STV2023121113__DWH.s_dialog_info(hk_message_id, message, message_from, message_to, load_dt, load_src)
SELECT
    ld.message_id,
    ld.message,
    ld.message_from,
    ld.message_to,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.dialogs AS ld;

------------------------------------------
-- Create s_user_socdem Satellite Table
DROP TABLE IF EXISTS STV2023121113__DWH.s_user_socdem;

CREATE TABLE STV2023121113__DWH.s_user_socdem
(
    hk_user_id INT NOT NULL CONSTRAINT fk_s_user_socdem_h_users REFERENCES STV2023121113__DWH.h_users (hk_user_id),
    country VARCHAR(100),
    age INT,
    load_dt DATETIME,
    load_src VARCHAR(20)
)
ORDER BY load_dt
SEGMENTED BY hk_user_id ALL NODES
PARTITION BY load_dt::DATE
GROUP BY calendar_hierarchy_day(load_dt::DATE, 3, 2);

-- Populate s_user_socdem
INSERT INTO STV2023121113__DWH.s_user_socdem(hk_user_id, country, age, load_dt, load_src)
SELECT
    hu.hk_user_id,
    su.country,
    su.age,
    NOW() AS load_dt,
    's3' AS load_src
FROM STV2023121113__STAGING.users AS su
JOIN STV2023121113__DWH.h_users AS hu ON su.id = hu.user_id;

