class Reference:
    def __init__(self, id, author, title, journal, year):
        self.id = id
        self.author = author
        self.title = title
        self.journal = journal
        self.year = year

    def __str__(self):
        return f"{self.author}. {self.title}. {self.journal}, {self.year}."