CREATE TABLE STV2023121113.dialogs
(
    message_id   INT PRIMARY KEY,
    message_ts   TIMESTAMP(6),
    message_from INT REFERENCES members(id),
    message_to   INT REFERENCES members(id),
    message      VARCHAR(1000),
    message_type VARCHAR(100)
)
SEGMENTED BY hash(message_id) ALL NODES;
