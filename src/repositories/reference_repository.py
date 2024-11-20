from config import db
from sqlalchemy import text

from entities.reference import Reference


def get_all_references():
    result = db.session.execute(text(
        f"SELECT r.id, STRING_AGG(a.author, ' & ') AS authors, r.title, r.journal, r.year, r.volume, \
            r.number, r.pages, r.month, r.note FROM articles r INNER JOIN authors a ON r.id = a.reference_id GROUP BY r.id"))
    contents = result.fetchall()
    return [Reference(*row) for row in contents]


def get_reference_by_id(id):
    result = db.session.execute(text(f"SELECT * FROM articles WHERE id = {id}"))
    contents = result.fetchall()
    columns = result.keys()
    return [dict(zip(columns, row)) for row in contents][0]


def delete_reference(id):
    db.session.execute(text(f"DELETE FROM articles WHERE id = {id}"))


def create_reference(authors, title, journal, year, volume, number, pages, month, note):
    volume = volume if volume else None
    number = number if number else None
    pages = pages if pages else None
    month = month if month else None
    note = note if note else None

    sql = text(
        "INSERT INTO articles (title, journal, year, volume, number, pages, month, note) \
            VALUES (:title, :journal, :year, :volume, :number, :pages, :month, :note) RETURNING id"
    )
    result = db.session.execute(
        sql,
        {
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
    id_of_new_row = result.fetchone()[0]

    for author in authors:
        create_author(author, id_of_new_row)

def edit_reference(authors, title, journal, year, volume, number, pages, month, note):
    pass

def create_author(author, reference_id):
    sql = text(
        "INSERT INTO authors (author, reference_id) VALUES (:author, :reference_id)")
    db.session.execute(
        sql, {"author": author, "reference_id": reference_id}
    )
    db.session.commit()


def generate_bibkey(reference):
    author = "".join([name.split()[-1][:4] for name in reference.authors.split(" & ")])
    title = reference.title[:3]
    year = reference.year
    return f"{author}{title}{year}"


def format_bibtex(reference):
    bibtex_str = ""
    bibtex_str += f"@article{{{str(generate_bibkey(reference))},\n"
    bibtex_str += f"  author = {{{str(reference.authors)}}}\n"
    bibtex_str += f"  title = {{{str(reference.title)}}}\n"
    bibtex_str += f"  journal = {{{str(reference.journal)}}}\n"
    bibtex_str += f"  year = {{{str(reference.year)}}}\n"
    

    if reference.volume:
        bibtex_str += f"  volume = {{{str(reference.volume)}}}\n"
    if reference.number:
        bibtex_str += f"  number = {{{str(reference.number)}}}\n"
    if reference.pages:
        bibtex_str += f"  pages = {{{str(reference.pages)}}}\n"
    if reference.month:
        bibtex_str += f"  month = {{{str(reference.month)}}}\n"
    if reference.note:
        bibtex_str += f"  note = {{{str(reference.note)}}}\n"
    
    bibtex_str += "}\n"

    return bibtex_str

def join_bibtex():
    result = db.session.execute(text(
        f"SELECT r.id, STRING_AGG(a.author, ' & ') AS authors, r.title, r.journal, r.year, r.volume, \
            r.number, r.pages, r.month, r.note FROM articles r INNER JOIN authors a ON r.id = a.reference_id GROUP BY r.id"))
    contents = result.fetchall()
    return "\n".join([format_bibtex(reference) for reference in contents])
