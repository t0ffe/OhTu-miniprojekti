from entities.references import get_reference_fields


class UserInputError(Exception):
    pass


def validate_reference(reference):

    fields = get_reference_fields(reference.type)

    for key in fields["required"]:
        if not getattr(reference, key, None):
            raise UserInputError(
                f"All mandatory fields must be filled, missing {key}")
        validate_field(reference, key)

    for key in fields["optional"]:
        if getattr(reference, key, None):
            validate_field(reference, key)


def validate_field(reference, key):
    if len(getattr(reference, key, None)) > 200:
        raise UserInputError(
            "Reference information length must be smaller than 200")
    if key == "authors" and len(reference.authors) > 21:
        raise UserInputError("Maximum number of authors is 21")
    if key == "year":
        is_valid_number(reference.year, 1, 2100)
    if key == "volume":
        is_valid_number(reference.volume, 1, 5000)
    if key == "edition":
        is_valid_number(reference.edition, 1, 5000)
    if key == "number":
        is_valid_number(reference.number, 1, 5000)
    if key == "month":
        is_valid_number(reference.month, 1, 12)


def is_valid_number(value, min_val, max_val):
    if value and (not value.isdigit() or not min_val <= int(value) <= max_val):
        raise UserInputError(
            f"{value} must be a number between {min_val}-{max_val}"
        )
