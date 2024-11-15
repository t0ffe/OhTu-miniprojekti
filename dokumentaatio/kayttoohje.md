# Ohjelman Käyttöohje

Linkki README.md tiedostoon: https://github.com/t0ffe/OhTu-miniprojekti/blob/main/README.md

## Asennus

1. Lataa ohjelman viimeisin versio (kloonaa repositorio omalle koneellesi)
    ```bash
    git clone https://github.com/t0ffe/OhTu-miniprojekti.git
    ```
2. Asenna tarvittavat riippuvuudet projektin juurihakemistossa:
    ```bash
    poetry install
    ```

3. Luo .env tiedosto:
    ```Dotenv
    DATABASE_URL=postgresql://xxx
    TEST_ENV=false   
    SECRET_KEY=satunnainen_merkkijono
    ```
   Huomaa, että `.env` tiedoston `DATABASE_URL` täytyy itse hakea jostain internetpalveluna tarjottavasta tietokannasta, esim. https://aiven.io. Lisäksi muokkaa TEST_ENV=true

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
