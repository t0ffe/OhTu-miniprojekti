from config import db
from sqlalchemy import text

from entities.reference import Reference


def get_all_references():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return [Reference(*row) for row in contents]


def get_reference_by_id(id):
    result = db.session.execute(text(f"SELECT * FROM articles WHERE id = {id}"))
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
        sql,
        {
            "author": author,
            "title": title,
            "journal": journal,
            "year": year,
            "volume": volume,
            "number": number,
            "pages": pages,
            "month": month,
            "note": note,
        },
    )
    db.session.commit()

def generate_bibkey(reference):
    author = reference.author[:3]
    title = reference.title[:3]
    year = reference.year
    return f'{author}{title}{year}'

def format_bibtex(reference):
    bibkey = generate_bibkey(reference)
    author = reference.author
    title = reference.title
    journal = reference.journal
    year = reference.year
    volume = reference.volume
    number = reference.number
    pages = reference.pages
    month = reference.month
    note = reference.note
    return f'@article{{{bibkey},\n  author = {{{author}}},\n  title = {{{title}}},\n  journal = {{{journal}}},\n  year = {{{year}}},\n  volume = {{{volume}}},\n  number = {{{number}}},\n  pages = {{{pages}}},\n  month = {{{month}}},\n  note = {{{note}}}\n}}'

def join_bibtex():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return '\n'.join([format_bibtex(reference) for reference in contents])