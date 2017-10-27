import MySQLdb

import config


def add_row(tb_name, data):
    db = MySQLdb.connect(config.mysql_server, config.mysql_un, config.mysql_pw, config.db_name)
    cursor = db.cursor()
    sql = "INSERT INTO %s" %tb_name
    columns = "(" + ", ".join(data.keys()) + ")"
    values = " VALUES " + "("
    for value in data.values():
        if type(value) is str:
            values += "'"+ value + "'" + ","
        else:
            values += str(value) + " ,"
    values = values [:-1] + ")"
    sql = sql + columns + values
    # print (sql)

    # cursor.execute(sql)
    # db.commit()

    try:
        # Execute the SQL command
        cursor.execute(sql)
        # Commit your changes in the database
        db.commit()
        id = cursor.lastrowid
    except Exception as e:
        print ("ERROR:", e)
        # Rollback in case there is any error
        db.rollback()
        id = 0

    db.close()

    return id

def get_row_by_fnKey(tb_name, field, value):
    db = MySQLdb.connect(config.mysql_server, config.mysql_un, config.mysql_pw, config.db_name)
    cursor = db.cursor()
    sql = "SELECT * FROM %s WHERE %s='%s'" %(tb_name, field, value)
    # print (sql)
    cursor.execute(sql)
    result = cursor.fetchone()
    db.close()

    return result

def get_last(tb_name, field, value, order_by):
    db = MySQLdb.connect(config.mysql_server, config.mysql_un, config.mysql_pw, config.db_name)
    cursor = db.cursor()
    sql = "SELECT * FROM %s WHERE %s='%s' ORDER BY %s DESC LIMIT 1" % (tb_name, field, value, order_by)
    # print (sql)
    cursor.execute(sql)
    result = cursor.fetchone()
    db.close()

    return result

def get_allrows(tb_name, where_field=None, where_value=None):
    db = MySQLdb.connect(config.mysql_server, config.mysql_un, config.mysql_pw, config.db_name)
    cursor = db.cursor()
    if where_field and where_value:
        if type(where_value) is str:
            sql = "SELECT * FROM %s WHERE %s='%s'" % (tb_name, where_field, where_value)
        elif type(where_value) is int:
            sql = "SELECT * FROM %s WHERE %s=%s" % (tb_name, where_field, str(where_value))
    else:
        sql = "SELECT * FROM %s" % tb_name

    cursor.execute(sql)
    results = cursor.fetchall()
    db.close()

    return results

def update(tbName, update_dict, where_dict):
    db = MySQLdb.connect(config.mysql_server, config.mysql_un, config.mysql_pw, config.db_name)
    cursor = db.cursor()

    sql = "UPDATE " + tbName + " SET "
    sql += ", ".join([key+"="+value for key, value in update_dict.iteritems()])
    sql += ' WHERE ' + ", ".join([key+"="+str(value) for key, value in where_dict.iteritems()])

    cursor.execute(sql)
    db.commit()
    db.close()

# print (get_fnKey('Categories', 'CategoryValue', 'comics'))
# print (get_last("OutputListPages", "QP_ID", 2, "seqNum"))

update('TaskList', {'IsDone': "'N'"}, {'TaskID': 1})
update('TaskList', {'IsDone': "'N'"}, {'TaskID': 2})


