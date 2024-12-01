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
        reference_mock.return_value = (1, "Author", "Editor", "Title", "Publisher", "2023", "1", "2", "3", "4", "Note", "reference")
  
        with self.assertRaises(UserInputError):
            validate_reference(reference_mock
                )
    
    def test_mandatory_missing_raises_error(self):
        reference_mock = Mock()
        reference_mock.return_value = (1, "Author", "Editor", "Title")
  
        with self.assertRaises(UserInputError):
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
        