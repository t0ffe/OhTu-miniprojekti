class PhDThesis:
    def __init__(
        self,
        ref_id,
        authors,
        title,
        school,
        year,
        thesis_type=None,
        address=None,
        month=None,
        note=None,
        type="phdthesis",
    ):
        self.id = ref_id
        self.authors = authors
        self.title = title
        self.school = school
        self.year = year
        self.thesis_type = thesis_type
        self.address = address
        self.month = month
        self.note = note
        self.type = type


    @staticmethod
    def from_form(form):
        return PhDThesis(
            form.get("reference_id") or None,
            form.getlist("author"),
            form.get("title"),
            form.get("school"),
            form.get("year"),
            form.get("thesis_type") or None,
            form.get("address") or None,
            form.get("month") or None,
            form.get("note") or None,
        )


    def __str__(self):
        thesis_type = None
        address = None
        month = None
        note = None

        if self.thesis_type:
            thesis_type = f"Type: {self.thesis_type}."

        if self.address:
            address = f"Address: {self.address}."

        if self.month:
            month = f"month: {self.month}."
            
        if self.note:
            note = f"Note: {self.note}."
        
        return f"{self.authors}. {self.title}. {self.school}. {self.year}. {thesis_type or ''} {address or ''} {month or ''} {note or ''}"