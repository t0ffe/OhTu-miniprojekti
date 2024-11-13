class UserInputError(Exception):
    pass

def validate_reference(author, title, journal, year):
    if not author or title or journal or year:
        raise UserInputError("All fields must be filled")

    if len(author) or len(title) or len(journal) or len(year) > 200:
    
        raise UserInputError("Reference information length must be smaller than 200")