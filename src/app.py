from flask import redirect, render_template, request, jsonify, flash
from db_helper import reset_db
from repositories.todo_repository import get_db_contents, create_todo
from config import app, test_env
from util import validate_todo


@app.route("/")
def index():
    return render_template("index.html")


@app.route("/new_todo")
def new():
    return render_template("new_todo.html")


@app.route("/create_reference", methods=["POST"])
def todo_creation():
    author = request.form.get("author")
    title = request.form.get("title")
    journal = request.form.get("journal")
    year = request.form.get("year")

    try:
        validate_todo(author, title, journal, year)
        create_todo(author, title, journal, year)
        return redirect("/")
    except Exception as error:
        flash(str(error))
        return redirect("/new_todo")

# testausta varten oleva reitti
if test_env:

    @app.route("/reset_db")
    def reset_database():
        reset_db()
        return jsonify({"message": "db reset"})
