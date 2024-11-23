class UserInputError(Exception):
    pass


def validate_reference(authors, title, journal, year, volume, number, pages, month, note):
    mandatory = [authors, title, journal, year]
    allfields = [authors, title, journal, year,
                 volume, number, pages, month, note]
    nonempty = []
    for field in allfields:
        if field:
            nonempty.append(field)

    if not all(mandatory):
        raise UserInputError("All mandatory fields must be filled")
    if any(len(field) > 200 for field in nonempty):
        raise UserInputError(
            "Reference information length must be smaller than 200")
    if year.isdigit() is False:
        raise UserInputError("Year must be a number between 1-2100")
    if int(year) < 1 or int(year) > 2100:
        raise UserInputError("Year must be a number between 1-2100")
    if volume != "":
        if volume.isdigit() is False:
            raise UserInputError("Volume must be a number between 1-5000")
        if int(volume) < 1 or int(volume) > 5000:
            raise UserInputError("Volume must be a number between 1-5000")
    if number != "":
        if number.isdigit() is False:
            raise UserInputError("Number must be a number between 1-5000")
        if int(number) < 1 or int(number) > 5000:
            raise UserInputError("Number must be a number between 1-5000")
    if month != "":
        if month.isdigit() is False:
            raise UserInputError("Month must be a number between 1-12")
        if int(month) < 1 or int(month) > 12:
            raise UserInputError("Month must be a number between 1-12")

    if len(authors) > 21:
        raise UserInputError("Maximum number of authors is 21")
