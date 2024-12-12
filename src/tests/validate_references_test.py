import unittest
from util import validate_reference, UserInputError
from entities.article import Article
from entities.book import Book
from entities.booklet import Booklet
from entities.conference import Conference
from entities.mastersthesis import Mastersthesis
from entities.phdthesis import PhDThesis


class TestReferenceValidation(unittest.TestCase):
    def setUp(self):
        pass

    def test_valid_length_does_not_raise_error(self):
        validate_reference(
            Article(
                1, "Author", "Title", "Journal", "2023", "3", "4", "12-14", "May", "note"
            )
        )
        validate_reference(
            Article(
                1,
                ["j", "j"],
                "h" * 100,
                "m" * 100,
                "2023",
                "3",
                "7",
                "5000",
                "4",
                "note" * 49,
            )
        )

    def test_too_short_or_long_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(1, "", "Title", "Journal", "2023",
                        "3", "", "5000", "", "note")
            )
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "koodaa" * 201,
                    "Title",
                    "Journal",
                    "2023",
                    "3",
                    "",
                    "5000",
                    "",
                    "note" * 45,
                )
            )

    def test_year_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "200000",
                    "3",
                    "",
                    "5000",
                    "",
                    "note",
                )
            )
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "testi",
                    "3",
                    "",
                    "5000",
                    "",
                    "note",
                )
            )

    def test_vol_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "2023",
                    "3000000000",
                    "",
                    "5000",
                    "",
                    "note",
                )
            )
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "2023",
                    "testi",
                    "",
                    "5000",
                    "",
                    "note",
                )
            )

    def test_number_too_much_or_str_raises_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "2023",
                    "3",
                    "40000000000",
                    "5000",
                    "",
                    "note",
                )
            )
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    "Author",
                    "Title",
                    "Journal",
                    "2023",
                    "3",
                    "testi",
                    "5000",
                    "",
                    "note",
                )
            )

    def test_too_many_authors(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Article(
                    1,
                    [f"author{author}" for author in range(22)],
                    "Title",
                    "Journal",
                    "2023",
                    "3",
                    "",
                    "5000",
                    "12",
                    "note",
                )
            )

    def test_valid_book_does_not_raise_error(self):
        validate_reference(
            Book(
                1, "Author", "Title", "Publisher", "2023", "1", "2", "3", "May", "Note"
            )
        )
        validate_reference(
            Book(
                1, "Author", "Title", "Publisher", "2023"
            )
        )

    def test_missing_publisher_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Book(1, "Author", "Title", "", "2023"
                     )
            )

    def test_valid_booklet_does_not_raise_error(self):
        validate_reference(
            Booklet(
                1, "Author", "Title", "Howpublished", "Address", "2023", "Editor", "4", "6", "organization", "May", "note"
            )
        )
        validate_reference(
            Booklet(
                1, "Author", "Title", "Howpublished", "Address", "2023"
            )
        )

    def test_missing_howpublished_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Booklet(
                1, "Author", "Title", "", "Address", "2021"
            )
            )

    def test_missing_address_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(Booklet(
                1, "Author", "Title", "Howpublished", "", "2023"
            )
            )

    def test_valid_conference_does_not_raise_error(self):
        validate_reference(
            Conference(
                1, "Author", "Title", "Booktitle", "2023", "Editor", "4", "6", "12-14", "address", "May", "organization", "publisher", "note"
            )
        )
        validate_reference(
            Conference(
                1, "Author", "Title", "Booktitle", "2023"
            )
        )

    def test_missing_booktitle_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Conference(
                    1, "Author", "Title", "", "2023"
                )
            )

    def test_valid_mastethesis_does_not_raise_error(self):
        validate_reference(
            Mastersthesis(
                1, "Author", "Title", "School", "2023", "Thesis_type", "Address", "May", "note"
            )
        )
        validate_reference(
            Mastersthesis(
                1, "Author", "Title", "School", "2023"
            )
        )

    def test_missing_school_does_raise_error(self):
        with self.assertRaises(UserInputError):
            validate_reference(
                Mastersthesis(
                    1, "Author", "Title", "", "2023"
                )
            )

    def test_valid_phdthesis_does_not_raise_error(self):
        validate_reference(
            PhDThesis(
                1, "Author", "Title", "School", "2023", "Thesis_type", "Address", "May", "note"
            )
        )
        validate_reference(
            PhDThesis(
                1, "Author", "Title", "School", "2023"
            )
        )
