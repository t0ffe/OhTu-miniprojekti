class UserInputError(Exception):
    pass

def validate_reference(author, title, journal, year, volume, number, pages, month, note):
    mandatory = [author, title, journal, year]
    allfields = [author, title, journal, year, volume, number, pages, month, note]
    nonempty = []
    for field in allfields:
        if field:
            nonempty.append(field)

    if not all(mandatory):
        raise UserInputError("All mandatory fields must be filled")

    if any(len(field) > 200 for field in nonempty):
        raise UserInputError("Reference information length must be smaller than 200")