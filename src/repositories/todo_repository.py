from config import db
from sqlalchemy import text

from entities.todo import Todo


def get_db_contents():
    result = db.session.execute(text(f"SELECT * FROM articles"))
    contents = result.fetchall()
    return [Todo(row[0], row[1], row[2], row[3]) for row in contents]


def set_done(todo_id):
    sql = text("UPDATE todos SET done = TRUE WHERE id = :id")
    db.session.execute(sql, {"id": todo_id})
    db.session.commit()


def create_todo(author, title, journal, year):
    sql = text("INSERT INTO articles (author, title, journal, year) VALUES (:author, :title, :journal, :year)")
    db.session.execute(sql, {"author": author, "title": title, "journal": journal, "year": year})
    db.session.commit()
