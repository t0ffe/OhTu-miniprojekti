from sqlalchemy import text
from config import db

from entities.article import Article
from entities.book import Book


def get_all_references():
    articles_res = db.session.execute(
        text(
            "SELECT r.id, STRING_AGG(a.author, ' & ') AS authors, r.title, r.journal, r.year, r.volume, \
            r.number, r.pages, r.month, r.note FROM referencetable r INNER JOIN authors a ON r.id = a.reference_id WHERE r.reftype = 'article' GROUP BY r.id"
        )
    )
    articles = articles_res.fetchall()

    books_res = db.session.execute(
        text(
            "SELECT r.id, STRING_AGG(a.author, ' & ') AS authors, r.editor, r.title, r.publisher, r.year, \
            r.volume, r.number, r.pages, r.month, r.note FROM referencetable r INNER JOIN authors a ON r.id = a.reference_id WHERE r.reftype = 'book' GROUP BY r.id"
        )
    )
    books = books_res.fetchall()

    return [Article(*row) for row in articles] + [Book(*row) for row in books]


def get_reference_by_id(ref_id, type):
    result = db.session.execute(
        text("SELECT * FROM referencetable WHERE id = :id"), {"id": ref_id}
    )
    contents = result.fetchall()
    columns = result.keys()
    reference = [dict(zip(columns, row)) for row in contents][0]
    reference["type"] = type
    return reference


def get_authors_by_reference_id(ref_id):
    result = db.session.execute(
        text("SELECT author FROM authors WHERE reference_id = :id"),
        {"id": ref_id},
    )
    contents = result.fetchall()
    return [row[0] for row in contents]


def delete_reference_db(ref_id):
    db.session.execute(
        text("DELETE FROM authors WHERE reference_id = :id"),
        {"id": ref_id},
    )
    db.session.execute(
        text("DELETE FROM referencetable WHERE id = :id"),
        {"id": ref_id},
    )
    db.session.commit()


def create_reference(reference):
    authors = reference.authors

    if reference.type == "article":
        sql = text(
            "INSERT INTO referencetable (title, journal, year, volume, number, pages, month, note, reftype) \
                VALUES (:title, :journal, :year, :volume, :number, :pages, :month, :note, :reftype) RETURNING id"
        )
        result = db.session.execute(
            sql,
            {
                "title": reference.title,
                "journal": reference.journal,
                "year": reference.year,
                "volume": reference.volume or None,
                "number": reference.number or None,
                "pages": reference.pages or None,
                "month": reference.month or None,
                "note": reference.note or None,
                "reftype": reference.type,
            },
        )

    elif reference.type == "book":
        sql = text(
            "INSERT INTO referencetable (editor, title, publisher, year, volume, number, pages, month, note, reftype) \
                VALUES (:editor, :title, :publisher, :year, :volume, :number, :pages, :month, :note, :reftype) RETURNING id"
        )
        result = db.session.execute(
            sql,
            {
                "editor": reference.editor,
                "title": reference.title,
                "publisher": reference.publisher,
                "year": reference.year,
                "volume": reference.volume,
                "number": reference.number,
                "pages": reference.pages,
                "month": reference.month,
                "note": reference.note,
                "reftype": reference.type,
            },
        )

    db.session.commit()
    id_of_new_row = result.fetchone()[0]

    for author in authors:
        create_author(author, id_of_new_row)


def edit_reference(reference):
    # assuming our future tables will be named like this
    fields = [
        attr
        for attr in reference.__dict__.keys()
        if attr not in ["id", "type", "authors"]
    ]

    set_clause = ", ".join([f"{field} = :{field}" for field in fields])
    update_reference_sql = text(
        f"UPDATE referencetable SET {set_clause} WHERE id = :reference_id"
    )

    params = {field: getattr(reference, field) for field in fields}
    params["reference_id"] = reference.id

    db.session.execute(update_reference_sql, params)

    remove_previous_authors_sql = text(
        "DELETE FROM authors WHERE reference_id = :reference_id"
    )
    db.session.execute(
        remove_previous_authors_sql,
        {"reference_id": reference.id},
    )

    for author in reference.authors:
        create_author(author, reference.id)

    db.session.commit()


def create_author(author, reference_id):
    sql = text(
        "INSERT INTO authors (author, reference_id) VALUES (:author, :reference_id)"
    )
    db.session.execute(sql, {"author": author, "reference_id": reference_id})
    db.session.commit()


def generate_bibkey(reference):
    author = "".join([name.split()[-1][:4] for name in reference.authors.split(" & ")])
    title = reference.title[:3]
    year = reference.year
    return f"{author}{title}{year}"


def join_bibtex():
    references = get_all_references()
    bibtex_entries = []
    for reference in references:
        bibtex_str = f"@{reference.__class__.__name__.lower()}{{{str(generate_bibkey(reference))},\n"
        for key, value in reference.__dict__.items():
            if key not in ["id", "type"] and value:
                bibtex_str += f"  {key} = {{{str(value)}}},\n"
        bibtex_str += "}\n"
        bibtex_entries.append(bibtex_str)
    return "\n".join(bibtex_entries)
