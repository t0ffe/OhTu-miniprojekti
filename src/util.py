class UserInputError(Exception):
    pass

def validate_reference(author, title, journal, year):
    if not author or not title or not journal or not year:
        raise UserInputError("All fields must be filled")

    if len(author) > 200 or len(title) > 200 or len(journal) > 200 or len(year) > 200:
        raise UserInputError("Reference information length must be smaller than 200")