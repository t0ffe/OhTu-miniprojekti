class Reference:
    def __init__(
        self,
        ref_id,
        authors,
        title,
        journal,
        year,
        volume=None,
        number=None,
        pages=None,
        month=None,
        note=None,
        type="article",
    ):
        self.id = ref_id
        self.authors = authors
        self.title = title
        self.journal = journal
        self.year = year
        self.volume = volume
        self.number = number
        self.pages = pages
        self.month = month
        self.note = note
        self.type = type

    @staticmethod
    def from_form(form):
        return Reference(
            form.get("reference_id") or None,
            form.getlist("author"),
            form.get("title"),
            form.get("journal"),
            form.get("year"),
            form.get("volume") or None,
            form.get("number") or None,
            form.get("pages") or None,
            form.get("month") or None,
            form.get("note") or None,
            "article",
        )

    def __str__(self):
        vol = None
        no = None
        pages = None
        month = None
        note = None

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
        return f"{self.authors}. {self.title}. {self.journal}, {self.year}. {vol or ''} {no or ''} {pages or ''} {month or ''} {note or ''}"
