vertica_user = 'stv2023121113'


# ///////////////
# CREATE TABLE MY_TABLE (
#     i int,
#     ts timestamp(6),
#     v varchar(1024),
#     PRIMARY KEY (i, ts)
# )
# ORDER BY i, v, ts
# SEGMENTED BY HASH(i, ts) ALL NODES;




# Not the 8th
# CREATE TABLE COPY_EX1 (
#     i int primary key,
#     v varchar(16)
# );

# /* Вставка хотя бы одной записи обязательна для нашего примера */
# INSERT INTO COPY_EX1 VALUES (1, 'wow');

# select export_objects('','COPY_EX1')



