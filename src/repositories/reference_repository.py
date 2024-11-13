from config import db
from sqlalchemy import text

from entities.reference import Reference


def get_db_contents():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return [
        Reference(
            row[0],
            row[1],
            row[2],
            row[3],
            row[4],
            row[5],
            row[6],
            row[7],
            row[8],
            row[9],
            row[10],
        )
        for row in contents
    ]


def create_reference(author, title, journal, year):
    sql = text(
        "INSERT INTO articles (author, title, journal, year) VALUES (:author, :title, :journal, :year)"
    )
    db.session.execute(
        sql, {"author": author, "title": title, "journal": journal, "year": year}
    )
    db.session.commit()
