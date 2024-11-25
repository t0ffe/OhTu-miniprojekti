class UserInputError(Exception):
    pass

def validate_reference(authors, title, journal, year, volume, number, pages, month, note):
    def is_valid_number(value, min_val, max_val):
        if value and (not value.isdigit() or not min_val <= int(value) <= max_val):
            raise UserInputError(f"{value} must be a number between {min_val}-{max_val}")

    mandatory = [authors, title, journal, year]
    allfields = [authors, title, journal, year, volume, number, pages, month, note]

    if not all(mandatory):
        raise UserInputError("All mandatory fields must be filled")
    if any(len(field) > 200 for field in allfields if field):
        raise UserInputError("Reference information length must be smaller than 200")

    is_valid_number(year, 1, 2100)
    is_valid_number(volume, 1, 5000)
    is_valid_number(number, 1, 5000)
    is_valid_number(month, 1, 12)

    if len(authors) > 21:
        raise UserInputError("Maximum number of authors is 21")
