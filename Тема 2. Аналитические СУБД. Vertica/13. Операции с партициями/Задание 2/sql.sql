-- Шаг 1: Создание клонированной таблицы dialogs_temp
drop table if exists dialogs_temp;
create table dialogs_temp like dialogs including projections;

-- Шаг 2: Копирование данных с преобразованием message_type в dialogs_temp
insert into dialogs_temp
select
    message_id,
    message_ts,
    message_from,
    message_to,
    message,
    coalesce(message_type, '0') as message_type  -- Преобразование NULL в 0
from dialogs
where datediff('month', message_ts, now()) < 4;

-- Шаг 3: Проверка наличия NULL в клоне
select
    THROW_ERROR('Остались NULL в клоне!') as test_nulls
from dialogs_temp
where message_type is NULL;

-- Шаг 4: swap_partitions для переноса данных
select swap_partitions_between_tables(
    'dialogs_temp', /* Название клонированной таблицы */
    'YYYY-MM-DD',   /* Начальная партиция диапазона */
    'YYYY-MM-DD',   /* Конечная партиция диапазона */
    'dialogs'       /* Название основной таблицы */
);

-- Шаг 5: Проверка наличия NULL в основной таблице
select
    THROW_ERROR('Остались NULL в основной таблице!') as test_nulls
from dialogs
where message_type is NULL
    and message_ts >= 'YYYY-MM-DD';  -- Замените YYYY-MM-DD на начальную дату диапазона
