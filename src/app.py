from io import BytesIO
from flask import redirect, render_template, request, jsonify, flash, send_file
from db_helper import reset_db
from repositories.reference_repository import (
    create_reference,
    get_all_references,
    get_reference_by_id,
    join_bibtex,
    edit_reference,
    delete_reference_db,
    get_authors_by_reference_id,
)
from config import app, test_env
from util import validate_reference
from entities.article import Article
from entities.book import Book


def reference_from_request(type):
    reference_objects = {
        "article": Article.from_form(request.form),
        "book": Book.from_form(request.form),
    }
    return reference_objects[type]


# Kotisivulle vievä funktio.
@app.route("/")
def index():
    return render_template("index.html")


# Uuden referenssin lisäyssivu.
@app.route("/new_reference")
def new():
    return render_template("new_reference.html")


# Uuden referensin luomisfunktio.
@app.route("/create_reference", methods=["POST"])
def reference_creation():
    reference_type = request.form.get("type")
    new_reference = reference_from_request(reference_type)
    try:
        validate_reference(new_reference)
        create_reference(new_reference)
        flash("Succesfully added reference!")
        return redirect("/new_reference")
    except Exception as error:
        flash(str(error))
        return redirect("/new_reference")


# Sivu joka listaa kaikki lisätyt referenssit.
@app.route("/list_references", methods=["GET"])
def list_references():
    references = get_all_references()
    return render_template("list_references.html", references=references)


# Funktio joka muuttaa referenssin bibtex muotoon ja näyttää sen sivulla.
@app.route("/references_as_bibtex")
def references_as_bibtex():
    bibtex = join_bibtex()
    return render_template("bibtex.html", bibtex=bibtex)


# Funktio joka lataa referenssit bibtex muodossa.
@app.route("/download_references_as_bibtex")
def download_references_as_bibtex():
    bibtex = join_bibtex()
    bibtex_io = BytesIO(bibtex.encode("utf-8"))
    bibtex_io.seek(0)

    return send_file(
        bibtex_io,
        mimetype="application/x-bibtex",
        as_attachment=True,
        download_name="bibliography.bib",
    )


# Funktio joka poistaa referenssin.
@app.route("/delete_reference", methods=["GET"])
def delete_reference():
    ref_id = request.args.get("id")
    if ref_id is not None:
        try:
            delete_reference_db(ref_id)
            flash("Succesfully removed reference!")
            return redirect("/list_references")
        except Exception as error:
            flash(str(error))
            return redirect("/list_references")


# Funktio, joka hoitaa article referenssin editoimisen.
@app.route("/edit_reference", methods=["POST", "GET"])
def reference_editing():
    if request.method == "GET":
        edit_id = request.args.get("id")
        edit_type = request.args.get("type")
        reference = get_reference_by_id(edit_id, edit_type)
        authors = get_authors_by_reference_id(edit_id)
        authors_string = ", ".join([author for author in authors])
        return render_template(
            "edit_reference.html", reference=reference, authors=authors_string
        )

    if request.method == "POST":
        reference_id = request.form.get("reference_id")
        reference_type = request.form.get("reference_type")
        authors = request.form.getlist("author")
        new_reference = reference_from_request(reference_type)
        try:
            validate_reference(new_reference)
            edit_reference(new_reference)
            flash("Succesfully edited reference!")
            return redirect("/list_references")

        except Exception as error:
            flash(str(error))
            return redirect(f"/edit_reference?id={reference_id}")


# testausta varten oleva reitti

if test_env:
    # Testauksessa resetoi tietokannan.
    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({"message": "db reset"})
