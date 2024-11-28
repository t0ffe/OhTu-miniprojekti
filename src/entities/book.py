class Book:
    def __init__(
        self,
        ref_id,
        authors,
        title,
        publisher,
        editor,
        year,
        address,
        volume=None,
        number=None,
        pages=None,
        month=None,
        note=None,
        type="book",
    ):
        self.id = ref_id
        self.authors = authors
        self.title = title
        self.publisher = publisher
        self.editor = editor
        self.address = address
        self.year = year
        self.volume = volume
        self.number = number
        self.pages = pages
        self.month = month
        self.note = note
        self.type = type

    @staticmethod
    def from_form(form):
        return Book(
            form.get("reference_id") or None,
            form.getlist("author"),
            form.get("title"),
            form.get("publisher"),
            form.get("editor"),
            form.get("year"),
            form.get("address") or None,
            form.get("volume") or None,
            form.get("number") or None,
            form.get("pages") or None,
            form.get("month") or None,
            form.get("note") or None,
            "book",
        )

    def __str__(self):
        vol = None
        no = None
        pages = None
        month = None
        note = None
        address = None

        if self.volume:
            vol = f"vol. {self.volume}."
        if self.number:
            no = f"no. {self.number}."
        if self.pages:
            pages = f"page(s) {self.pages}."
        if self.month:
            month = f"month: {self.month}."
        if self.note:
            note = f"notes: {self.note}."
        if self.address:
            address = f"address: {self.address}."
        return f"{self.title}. {self.authors}. {self.year}, {self.publisher},{self.address}. {vol or ''} {no or ''} {pages or ''} {month or ''} {note or ''}"
