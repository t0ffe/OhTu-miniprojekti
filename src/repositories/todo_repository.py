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


def create_todo(content):
    sql = text("INSERT INTO todos (content) VALUES (:content)")
    db.session.execute(sql, {"content": content})
    db.session.commit()
