from sqlalchemy import text
from config import db, app

REFERENCE_TABLE = "referencetable"
AUTHOR_TABLE = "authors"


def table_exists(name):
    sql_table_existence = text(
        "SELECT EXISTS ("
        "  SELECT 1"
        "  FROM information_schema.tables"
        f" WHERE TABLE_NAME = '{name}'"
        ")"
    )

    print(f"Checking if table {name} exists")
    print(sql_table_existence)

    result = db.session.execute(sql_table_existence)
    return result.fetchall()[0][0]


def reset_db():
    print(f"Clearing contents from table {AUTHOR_TABLE}")
    sql = text(f"DELETE FROM {AUTHOR_TABLE}")
    db.session.execute(sql)
    db.session.commit()

    print(f"Clearing contents from table {REFERENCE_TABLE}")
    sql = text(f"DELETE FROM {REFERENCE_TABLE}")
    db.session.execute(sql)
    db.session.commit()


def setup_db():
    if table_exists(REFERENCE_TABLE):
        print(f"Table {REFERENCE_TABLE} exists, dropping")
        sql = text(f"DROP TABLE {REFERENCE_TABLE} CASCADE")
        db.session.execute(sql)
        db.session.commit()

    print(f"Creating table {REFERENCE_TABLE}")
    sql = text(
        f"CREATE TABLE {REFERENCE_TABLE} ("
        "  id SERIAL PRIMARY KEY, "
        "  title TEXT NOT NULL, "
        "  year INT NOT NULL, "
        "  journal TEXT, "
        "  volume INT, "
        "  pages TEXT, "
        "  month INT, "
        "  editor TEXT, "
        "  publisher TEXT, "
        "  edition INT, "
        "  number INT, "
        "  booktitle TEXT, "
        "  series TEXT, "
        "  address TEXT, "
        "  organization TEXT, "
        "  institution TEXT, "
        "  school TEXT, "
        "  howpublished TEXT, "
        "  note TEXT, "
        "  thesis_type TEXT, "
        "  reftype TEXT "
        ")"
    )

    db.session.execute(sql)
    db.session.commit()

    if table_exists(AUTHOR_TABLE):
        print(f"Table {AUTHOR_TABLE} exists, dropping")
        sql = text(f"DROP TABLE {AUTHOR_TABLE}")
        db.session.execute(sql)
        db.session.commit()

    print(f"Creating table {AUTHOR_TABLE}")
    sql = text(
        f"CREATE TABLE {AUTHOR_TABLE} ("
        "  id SERIAL PRIMARY KEY, "
        "  author TEXT NOT NULL, "
        "  reference_id INT "
        ")"
    )

    db.session.execute(sql)
    db.session.commit()


if __name__ == "__main__":
    with app.app_context():
        setup_db()
