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
    if year < 1 or year > 2100:
            raise UserInputError("Year must be between 1-2100")
    if volume < 1 or volume > 5000:
        raise UserInputError("Volume must be between 1-5000")
    if number < 1 or number > 5000:
        raise UserInputError("Number must be between 1-5000")
    if pages < 2 or pages > 5000:
        raise UserInputError("Pages must be between 1-5000")
    if month < 1 or month > 12:
        raise UserInputError("Month must be between 1-12")