from sqlalchemy import text 
from config import db
from entities.article import Article
from entities.book import Book
from entities.conference import Conference
from entities.booklet import Booklet
from entities.mastersthesis import Mastersthesis
from entities.phdthesis import PhDThesis




FIELD_CONTENTS = {
    "article": ["title", "journal", "year", "volume", "number", "pages", "month", "note"],
    "book": ["title", "publisher", "year", "volume", "number", "pages", "month", "note"],
    "booklet": ["title", "howpublished", "address", "year", "editor", "volume", "number", "organization", "month", "note"],
    "conference" : ["title", "booktitle", "year", "editor", "volume", "number", "pages", "address", "month", "organization", "publisher", "note"],
    "mastersthesis" : ["title", "school", "year", "thesis_type", "address", "month", "note"],
    "phdthesis" : ["title", "school", "year", "thesis_type", "address", "month", "note"]
}




def get_all_references():
    reference_types = {
        "article": Article,
        "book": Book,
        "booklet": Booklet,
        "conference": Conference,
        "mastersthesis": Mastersthesis,
        "phdthesis": PhDThesis
    }

    references = []

    for reference_type, entity_of_class in reference_types.items():
        rows_of_entity = get_all_references_of_type(reference_type)
        
        for row in rows_of_entity:
            reference = entity_of_class(*row)
            references.append((reference.id, reference.type, reference))
    return references




def get_all_references_of_type(reference_type):
    fields = FIELD_CONTENTS.get(reference_type)

    if not fields:
        raise ValueError(f"Invalid reference type: {reference_type}")

    field_names = ", ".join(fields)

    sql = text(
        "SELECT r.id, STRING_AGG(a.author, ' & ') AS authors, " + field_names + " FROM referencetable r INNER JOIN authors a \
            ON r.id = a.reference_id WHERE r.reftype =:reference_type GROUP BY r.id"
    )
    result = db.session.execute(sql, {"reference_type": reference_type})
    references = result.fetchall()
    return references




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
    fields = FIELD_CONTENTS.get(reference.type)

    if not fields:
        raise ValueError(f"Invalid reference type: {reference.type}")

    field_places = ", ".join(f":{field}" for field in fields)
    field_names = ", ".join(fields)

    sql = text(
        "INSERT INTO referencetable (" + field_names + ", reftype) "
        "VALUES (" + field_places + ", :reftype) RETURNING id"
    )

    parameters = {field: getattr(reference, field, None) for field in fields}
    parameters["reftype"] = reference.type
    result = db.session.execute(sql, parameters)
    db.session.commit()
    row_id = result.fetchone()[0]
    for author in reference.authors:
        create_author(author, row_id)




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
    author = "".join([name.split()[-1][:4]
                     for name in reference.authors.split(" & ")])
    title = reference.title[:3]
    year = reference.year
    return f"{author}{title}{year}"




def join_bibtex():
    references = get_all_references()
    bibtex_entries = []
    for reference in references:
        bibtex_str = f"@{reference[2].__class__.__name__.lower()}{{{str(generate_bibkey(reference[2]))},\n"
        for key, value in reference[2].__dict__.items():
            if key not in ["id", "type"] and value:
                bibtex_str += f"  {key} = {{{str(value)}}},\n"
        bibtex_str += "}\n"
        bibtex_entries.append(bibtex_str)
    return "\n".join(bibtex_entries)
