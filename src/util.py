class UserInputError(Exception):
    pass


def validate_reference(reference):
    def is_valid_number(value, min_val, max_val):
        if value and (not value.isdigit() or not min_val <= int(value) <= max_val):
            raise UserInputError(
                f"{value} must be a number between {min_val}-{max_val}"
            )   
    if reference.type == "book":
        mandatory = [reference.authors, reference.editor, reference.title,  reference.publisher, reference.year ]
        allfields = [
            reference.authors,
            reference.editor,
            reference.title,
            reference.publisher,
            reference.year,
            reference.volume,
            reference.number,
            reference.pages,
            reference.month,
            reference.note,
        ]

    elif reference.type == "article":
        mandatory = [reference.authors, reference.title, reference.journal, reference.year]
        allfields = [
            reference.authors,
            reference.title,
            reference.journal,
            reference.year,
            reference.volume,
            reference.number,
            reference.pages,
            reference.month,
            reference.note,
        ]
    

    if not all(mandatory):
        raise UserInputError("All mandatory fields must be filled")
    if any(len(field) > 200 for field in allfields if field):
        raise UserInputError("Reference information length must be smaller than 200")

    is_valid_number(reference.year, 1, 2100)
    is_valid_number(reference.volume, 1, 5000)
    is_valid_number(reference.number, 1, 5000)
    is_valid_number(reference.month, 1, 12)

    if len(reference.authors) > 21:
        raise UserInputError("Maximum number of authors is 21")
