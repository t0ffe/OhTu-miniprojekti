from flask import redirect, render_template, request, jsonify, flash
from db_helper import reset_db
from repositories.reference_repository import get_db_contents, create_reference, get_all_references
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
        validate_reference(author, title, journal, year, volume, number, pages, month, note)
        create_reference(author, title, journal, year, volume, number, pages, month, note)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        return redirect("/new_reference")


@app.route("/view_references")
def view_references():
    references = get_db_contents()
    return render_template("view_references.html")


@app.route("/toggle_reference/<reference_id>", methods=["POST"])
def toggle_reference(reference_id):
    return redirect("/")

@app.route("/list_references", methods=["GET"])
def list_references():
    references = get_all_references()
    return render_template("list_references.html", references=references)




# testausta varten oleva reitti
if test_env:

    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({"message": "db reset"})
