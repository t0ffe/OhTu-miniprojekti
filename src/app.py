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


# Kotisivulle vievä funktio.
@app.route("/")
def index():
    return render_template("index.html")


# Uuden referensin lisäys sivu.
@app.route("/new_reference")
def new():
    return render_template("new_reference.html")


# Uuden article-tyypisen referensin luomis funktio.
@app.route("/create_reference", methods=["POST"])
def reference_creation():
    # type = request.args.get("type")
    # Tämä pitää saada front-end puolelta kun tekee uuden viitteen.
    # if type == "article":
    new_reference = Article.from_form(request.form)
    # if type == "book":
    #     new_reference = Article.from_form(request.form)
    try:
        validate_reference(new_reference)
        create_reference(new_reference)
        flash("Succesfully added reference!")
        return redirect("/new_reference")
    except Exception as error:
        flash(str(error))
        return redirect("/new_reference")


# Sivu joka listaa kaikki lisätyt referensit.
@app.route("/list_references", methods=["GET"])
def list_references():
    references = get_all_references()
    return render_template("list_references.html", references=references)


# Funktio joka muuttaa referensin bibtext muotoon ja näyttää sen sivulla.
@app.route("/references_as_bibtex")
def references_as_bibtex():
    bibtex = join_bibtex()
    return render_template("bibtex.html", bibtex=bibtex)


# Funktio joka lataa referensit bibtext muodossa.
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


# Funktio joka poistaa referensin.
@app.route("/delete_reference", methods=["GET"])
def delete_reference():
    ref_id = request.args.get("id")
    type = request.args.get("type")
    if ref_id is not None:
        try:
            delete_reference_db(ref_id, type)
            flash("Succesfully removed reference!")
            return redirect("/list_references")
        except Exception as error:
            flash(str(error))
            return redirect("/list_references")


# Funktio, joka hoitaa article referensin editoimisen.
@app.route("/edit_reference", methods=["POST", "GET"])
def reference_editing():
    if request.method == "GET":
        edit_id = request.args.get("id")
        reference = get_reference_by_id(edit_id)
        authors = get_authors_by_reference_id(edit_id)
        return render_template(
            "edit_reference.html", reference=reference, authors=authors
        )
    if request.method == "POST":
        reference_id = request.form.get("reference_id")
        authors = request.form.getlist("author")

        new_reference = Reference.from_form(request.form)

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
