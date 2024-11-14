from config import db
from sqlalchemy import text

from entities.reference import Reference


def get_db_contents():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return [Reference(*row) for row in contents]


def create_reference(author, title, journal, year, volume):
    if not volume:
        volume = None
    sql = text(
        "INSERT INTO articles (author, title, journal, year, volume) VALUES (:author, :title, :journal, :year, :volume)"
    )
    db.session.execute(
        sql, {"author": author, "title": title, "journal": journal, "year": year, "volume":volume}
    )
    db.session.commit()
