import unittest
from util import validate_reference, UserInputError
from entities.booklet import Booklet


class TestReferenceValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_booklet_does_not_raise_error(self):
        validate_reference(
            Booklet(
                1, "Author", "Title", "Howpublished", "Address", "2023", "Editor", "4", "6", "organization", "5", "note"
            )
        )
        validate_reference(
            Booklet(
                1, "Author", "Title", "Howpublished", "Address", "2023"
            )
        )

    def test_valid_booklet_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Booklet(
                1, "Author", "Title", "Howpublished", "Address", "Text_Year"
            )
            )
        with self.assertRaises(UserInputError):
            validate_reference(Booklet(
                1, "Author", "Title", "Howpublished", "Address", "2023", "virhe"*100
            )
            )
