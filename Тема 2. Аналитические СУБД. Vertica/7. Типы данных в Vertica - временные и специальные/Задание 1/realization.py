vertica_user = 'stv2023121113'



# create table STV2023121113.orders
# (
#     id  varchar(2000) PRIMARY KEY,
#     registration_ts timestamp(6),
#     user_id varchar(2000),
#     is_confirmed int
# )
# ORDER BY id
# SEGMENTED BY HASH(id) ALL NODES
# ;



# create table STV2023121113.orders_v2
# (
#     id AUTO_INCREMENT PRIMARY KEY,
#     registration_ts TIMESTAMP(6),
#     user_id INT,
#     is_confirmed BOOLEAN
# )
# ORDER BY id
# SEGMENTED BY HASH(id) ALL NODES;