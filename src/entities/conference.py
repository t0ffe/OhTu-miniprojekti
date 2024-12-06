class Conference:
    def __init__(
        self,
        ref_id,
        authors,
        title,
        booktitle,
        year,
        editor=None,
        volume=None,
        number=None,
        pages=None,
        address=None,
        month=None,
        organization=None,
        publisher=None,
        note=None,
        type="conference",
    ):
        self.id = ref_id
        self.authors = authors
        self.title = title
        self.booktitle = booktitle
        self.year = year
        self.editor = editor
        self.volume = volume
        self.number = number
        self.pages = pages
        self.address = address
        self.month = month
        self.organization = organization
        self.publisher = publisher
        self.note = note
        self.type = type

    @staticmethod
    def from_form(form):
        return Conference(
            form.get("reference_id") or None,
            form.getlist("author"),
            form.get("title"),
            form.get("booktitle"),
            form.get("year"),
            form.get("editor"),
            form.get("volume") or None,
            form.get("number") or None,
            form.get("pages") or None,
            form.get("address") or None,
            form.get("month") or None,
            form.get("organization") or None,
            form.get("publisher") or None,
            form.get("note") or None,
        )

    def __str__(self):
        editor = None
        vol = None
        no = None
        pages = None
        address = None
        month = None
        organization = None
        publisher = None
        note = None

        if self.editor:
            editor = f"editor: {self.editor}."
        if self.volume:
            vol = f"vol. {self.volume}."
        if self.number:
            no = f"no. {self.number}."
        if self.pages:
            pages = f"page(s) {self.pages}."
        if self.address:
            address = f"address: {self.address}."
        if self.month:
            month = f"month: {self.month}."
        if self.organization:
            organization = f"organization: {self.organization}."
        if self.publisher:
            publisher = f"publisher: {self.publisher}."
        if self.note:
            note = f"notes: {self.note}."
        
        return f"{self.authors}. {self.title}. In {self.booktitle} ({self.year}). {editor or ''} {vol or ''} {no or ''} {pages or ''} {address or ''} {month or ''} {organization or ''} {publisher or ''} {note or ''}"
