import unittest
from util import validate_reference, UserInputError

class TestReferenceValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_length_does_not_raise_error(self):
        validate_reference("Author", "Title", "Journal", "2023")
        validate_reference("j" * 100, "h" * 100, "m" * 100, "2023")

    def test_too_short_or_long_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference("", "Title", "Journal", "2023")

        with self.assertRaises(UserInputError):
            validate_reference("koodaa" * 201, "Title", "Journal", "2023")   
