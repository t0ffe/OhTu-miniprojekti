class Reference:
    def __init__(
        self,
        id,
        author,
        title,
        journal,
        year,
        volume=None,
        number=None,
        pages=None,
        month=None,
        note=None,
    ):
        self.id = id
        self.author = author
        self.title = title
        self.journal = journal
        self.year = year
        self.volume = volume
        self.number = number
        self.pages = pages
        self.month = month
        self.note = note

    def __str__(self):
        return f"{self.author}. {self.title}. {self.journal}, {self.year}."
