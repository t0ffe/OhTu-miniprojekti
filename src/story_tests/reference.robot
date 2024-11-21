*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
Main Page Should Be Open
    Go To  ${HOME_URL}
    Title Should Be  References App
    Page Should Contain  This is an app for the client to add article type references and inspect them in BibTex- format
    Page Should Contain  The client can also edit and remove added references
    Page Should Contain  The app is created by LateXin Ritarit during the course Ohjelmistotuotanto (5 op)
    Page Should Contain  Creators:
    Page Should Contain  Tofelius Laakso
    Page Should Contain  Heidi Tapani
    Page Should Contain  Daniel Kalske
    Page Should Contain  Emilia Koponen
    Page Should Contain  Matias Ilola
    Page Should Contain  Kety Kuusaru

Click All References Link
    Go To  ${HOME_URL}
    Click Link  All references
    Title Should Be  Reference List

Click New Reference List Link
    Go To  ${HOME_URL}
    Click Link  New reference
    Page Should Contain  Add a new article type reference

After adding a reference there is one
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen (2020)

After adding two references there is two
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Input Text  author  Aki Artikuloija
    Input Text  title  Parempi Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen (2020)
    Page Should Contain  Aki Artikuloija. Parempi Artikkeli. Lehtinen (2022)
    Page Should Not Contain    vol.
    Page Should Not Contain    no.
    Page Should Not Contain    page(s)
    Page Should Not Contain    month:
    Page Should Not Contain    notes:

After adding voluntary information there is info
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Paras Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Input Text  volume  3
    Input Text  number  2
    Input Text  pages  142
    Input Text  month  5
    Input Text  note  Muistiin
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Aki Artikuloija. Paras Artikkeli. Lehtinen (2022)
    Page Should Contain  vol. 3
    Page Should Contain  no. 2.
    Page Should Contain  page(s) 142.
    Page Should Contain  month: 5.
    Page Should Contain  notes: Muistiin.

After editing author author is different
    Go To  ${NEW_REFERENCE}
    Input Text  author  Aki Artikuloija
    Input Text  title  Paras Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Aki Artikuloija. Paras Artikkeli. Lehtinen (2022)
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Page Should Contain  Succesfully added reference!
    Page Should Contain  Kari Kirjoittelija. Paras Artikkeli. Lehtinen (2022)

After removing optional information there is only mandatory
    Go To  ${NEW_REFERENCE}
    Input Text  author  Kari Kirjoittelija
    Input Text  title  Paras Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Input Text  volume  2
    Input Text  number  4
    Input Text  pages  10
    Input Text  month  5
    Input Text  note  Opiskele
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Kari Kirjoittelija. Paras Artikkeli. Lehtinen (2022)
    Page Should Contain  vol. 2
    Page Should Contain  no. 4
    Page Should Contain  page(s) 10
    Page Should Contain  month: 5
    Page Should Contain  notes: Opiskele.
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Page Should Contain  Succesfully added reference!
    Page Should Contain  Kari Kirjoittelija. Paras Artikkeli. Lehtinen (2022)

After deleting one reference
    Go To  ${NEW_REFERENCE}
    Input Text  author  Kari Kirjoittelija
    Input Text  title  Paras Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Button  All references
    Page Should Contain  Kari Kirjoittelija. Paras Artikkeli. Lehtinen (2022)
    Click Button  Delete
    Page Should Contain  Succesfully removed reference!
