from flask import redirect, render_template, request, jsonify, flash
from db_helper import reset_db
from repositories.reference_repository import (
    create_reference,
    get_all_references,
    get_reference_by_id,
    join_bibtex
)
from config import app, test_env
from util import validate_reference


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/new_reference")
def new():
    return render_template("new_reference.html")


@app.route("/create_reference", methods=["POST"])
def reference_creation():
    author = request.form.get("author")
    title = request.form.get("title")
    journal = request.form.get("journal")
    year = request.form.get("year")
    volume = request.form.get("volume")
    number = request.form.get("number")
    pages = request.form.get("pages")
    month = request.form.get("month")
    note = request.form.get("note")

    try:
        validate_reference(
            author, title, journal, year, volume, number, pages, month, note
        )
        create_reference(
            author, title, journal, year, volume, number, pages, month, note
        )
        flash("Succesfully added reference!")
        return redirect("/new_reference")
    except Exception as error:
        flash(str(error))
        return redirect("/new_reference")


@app.route("/list_references", methods=["GET"])
def list_references():
    references = get_all_references()
    return render_template("list_references.html", references=references)

@app.route("/references_as_bibtex")
def references_as_bibtex():
    bibtex = join_bibtex()
    return render_template("bibtex.html", bibtex=bibtex)

@app.route("/delete_reference", methods=["GET"])
def delete_reference():
    reference_id = request.args.get("id")



# testausta varten oleva reitti
if test_env:

    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({"message": "db reset"})
