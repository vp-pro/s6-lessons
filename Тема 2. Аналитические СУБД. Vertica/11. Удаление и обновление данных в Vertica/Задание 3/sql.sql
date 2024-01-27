COPY members(id, age, gender, email ENFORCELENGTH )
FROM LOCAL 'C:\Users\Vladislav\Downloads\members_inc.csv'
DELIMITER ';'
REJECTED DATA AS TABLE members_rej;


create table members_inc
(
        id int NOT NULL,
        age int,
        gender char,
        email varchar(50),
        CONSTRAINT C_PRIMARY PRIMARY KEY (id) DISABLED
)
ORDER BY id
SEGMENTED BY HASH(id) ALL NODES;



copy members_inc (id, age, gender, email)
from
    local 'C:\Users\Vladislav\Downloads\members_inc.csv'
delimiter ';'


--------------------------
MERGE INTO
    members /* имя таблицы в которой будут обновляться данные и в которую будут вставлены новые записи*/
USING
    members_inc /*таблица или подзапрос, из которой нужно взять данные*/
ON  /* ключи MERGE */
    members.id = members_inc.id
WHEN MATCHED and (
    members.id != members_inc.id
)
    THEN UPDATE SET
                gender = members_inc.gender,
                email = members_inc.email,
                age = members_inc.age
WHEN NOT MATCHED
    THEN INSERT (
                id,
                age,
                gender,
                email
        )
    VALUES (
                members_inc.id,
                members_inc.age,
                members_inc.gender,
                members_inc.email
        )
;


