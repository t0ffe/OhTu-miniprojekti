import unittest
from util import validate_reference, UserInputError
from entities.book import Book
from unittest.mock import Mock


class TestReferenceValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_length_does_not_raise_error(self):
        validate_reference(
            Book(
                1, "Author", "Editor", "Title", "Publisher", "2023", "1", "2", "3", "4", "Note"
            )
        )
        validate_reference(
            Book(
                1,
                ["a", "a"],
                "e" * 100,
                "t" * 100,
                "p" * 100,
                "2023",
                "3",
                "7",
                "5000",
                "4",
                "note" * 49,
            )
        )

    def test_invalid_reference_type_raises_error(self):
        reference_mock = Mock()
        reference_mock.return_value = (
            1, "Author", "Editor", "Title", "Publisher", "2023", "1", "2", "3", "4", "Note", "reference")

        with self.assertRaises(ValueError):
            validate_reference(reference_mock
                               )

    def test_mandatory_missing_raises_error(self):
        reference_mock = Mock()
        reference_mock.return_value = (1, "Author", "Editor", "Title")

        with self.assertRaises(ValueError):
            validate_reference(reference_mock
                               )

    def test_too_short_or_long_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Book(
                    1,
                    "",
                    "e" * 100,
                    "t" * 100,
                    "p" * 100,
                    "2023",
                    "3",
                    "7",
                    "5000",
                    "4",
                    "note" * 49,
                )
            )

        with self.assertRaises(UserInputError):
            validate_reference(
                Book(
                    1,
                    ["a", "a"],
                    "e" * 201,
                    "t" * 100,
                    "p" * 100,
                    "2023",
                    "3",
                    "7",
                    "5000",
                    "4",
                    "note" * 49,
                )
            )

    def test_year_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "yeartest"
            ))
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2101"
            ))

    def test_vol_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "5001"
            ))
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "volume"

            ))

    def test_number_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "5", "5001"
            ))
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "5", "number"
            ))

    def test_month_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "5", "50", "532", "13"
            ))
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, "Author1", "Title", "Publisher", "Editor", "2024", "5", "50", "532", "month"
            ))

    def test_too_many_authors(self):
        with self.assertRaises(UserInputError):
            validate_reference(Book(
                1, [f"author{author}" for author in range(22)],
                "Title", "Publisher", "Editor", "2024", "5", "50", "13"
            ))
