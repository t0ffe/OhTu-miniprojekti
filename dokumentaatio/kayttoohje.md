# Ohjelman Käyttöohje

## Asennus

1. Lataa ohjelman viimeisin versio
    ```bash
    git clone https://github.com/t0ffe/OhTu-miniprojekti.git
    ```
2. Asenna tarvittavat riippuvuudet:
    ```bash
    poetry install
    ```

3. Luo .env tiedosto:
    ```Dotenv
    DATABASE_URL=postgresql://xxx
    TEST_ENV=true   
    SECRET_KEY=satunnainen_merkkijono
    ```

4. Alusta tietokanta komennolla:
    ```bash
    poetry run python3 src/db_helper.py
    ```


## Ohjelman käynnistys- ja käyttöohje
Avaa ensin Poetry virtuaaliympäristö komennolla:
```bash
poetry shell
```

Avaa sovellus selaimessa esim. VSCoden terminaalissa komennolla:
```bash
python src/index.py
```

Yksikkötestit suoritetaan komennolla:
```bash
pytest src/tests
```

Robot-testit suoritetaan komennolla:
```bash
robot src/story_tests
```

Testikattavuusraportin generointi komennolla:
```bash
poetry coverage 
```

Pylint tarkistus komennolla:
```bash
poetry run invoke lint
```
-->
