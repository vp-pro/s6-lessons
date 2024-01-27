import vertica_python


vertica_user = 'stv2023121113'

conn_info = {'host': 'vertica.tgcloudenv.ru',
             'port': '5433',
             'user': 'stv2023121113',
             'password': 'CSjhrsfb9BYEaj1',
             'database': 'dwh',
             # Вначале он нам понадобится, а дальше — решите позже сами
            'autocommit': True
}

def try_select(conn_info=conn_info):
    N = 10000
    batch = 5

    with vertica_python.connect(**conn_info) as conn:
        curs = conn.cursor()
        insert_stmt = 'INSERT INTO BAD_IDEA VALUES ({},\'a\');'

        for i in range(0, N, batch):
            # будем отправлять сразу по несколько команд
            curs.execute(
                '\n'.join(
                    [insert_stmt.format(i + j) for j in range(batch)])
            )

        curs.commit()

