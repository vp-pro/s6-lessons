vertica_user = 'stv2023121113'

# drop table STV2023121113.members;

# ALTER TABLE STV2023121113.dialogs DROP CONSTRAINT IF EXISTS C_FOREIGN;
# ALTER TABLE STV2023121113.dialogs DROP CONSTRAINT IF EXISTS C_FOREIGN_1;

# create table members
# (
#     id int PRIMARY KEY,
#     age int,
#     gender varchar(8),
#     email varchar(256)
# )
# order by id
# segmented by hash(id) all nodes;

# copy members (
#         id, age, gender, email)
# from
#         local 'C:\Users\Vladislav\Downloads\members.csv'
# delimiter ';';



# drop table if exists STV2023121113.dialogs;

# create table STV2023121113.dialogs
# (
#     message_id   INT PRIMARY KEY,
#     message_ts   TIMESTAMP(6),
#     message_from INT REFERENCES STV2023121113.members(id),
#     message_to   INT REFERENCES STV2023121113.members(id),
#     message      VARCHAR(1000),
#     message_group INT
# )
# ORDER BY message_from, message_ts
# SEGMENTED BY HASH(message_id) ALL NODES;




# copy STV2023121113.dialogs (
#         message_id, message_ts, message_from, message_to, message, message_group)
# from
#         local 'C:\Users\Vladislav\Downloads\dialogs.csv'
# delimiter ';';
