from config import db
from sqlalchemy import text

from entities.reference import Reference


def get_all_references():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return [Reference(*row) for row in contents]


def create_reference(author, title, journal, year, volume, number, pages, month, note):
    volume = volume if volume else None
    number = number if number else None
    pages = pages if pages else None
    month = month if month else None
    note = note if note else None

    sql = text(
        "INSERT INTO articles (author, title, journal, year, volume, number, pages, month, note) \
            VALUES (:author, :title, :journal, :year, :volume, :number, :pages, :month, :note)"
    )
    db.session.execute(
        sql, {"author": author, "title": title, "journal": journal, "year": year,
              "volume": volume, "number": number, "pages": pages, "month": month, "note": note}
    )
    db.session.commit()
