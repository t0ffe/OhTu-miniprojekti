*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Variables ***
${AUTHOR}  Aki Artikuloija
${TITLE}  Artikkeli
${YEAR}  2020
${JOURNAL}  Lehtinen

*** Keywords ***
Add Reference
    [Arguments]  ${author}  ${title}  ${year}  ${journal}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  year  ${year}
    Input Text  journal  ${journal}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${pages}' != 'None'  Input Text  pages  ${pages}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add
    Page Should Contain  Succesfully added reference!

Verify Reference
    [Arguments]  ${author}  ${title}  ${journal}  ${year}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${journal} (${year})
    Run Keyword If  '${volume}' != 'None'  Page Should Contain  vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain  no. ${number}
    Run Keyword If  '${pages}' != 'None'  Page Should Contain  page(s) ${pages}
    Run Keyword If  '${month}' != 'None'  Page Should Contain  month: ${month}
    Run Keyword If  '${note}' != 'None'  Page Should Contain  notes: ${note}

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

All References Link Should Be Clickable
    Go To  ${HOME_URL}
    Click Link  All references
    Title Should Be  Reference List

New Reference Link Should Be Clickable
    Go To  ${HOME_URL}
    Click Link  New reference
    Page Should Contain  Add a new article type reference

Single Reference Should Be Added
    Add Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Click Button  All references
    Verify Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}

Two References Should Be Added
    Add Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Add Reference  ${AUTHOR}  Parempi Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}
    Verify Reference  ${AUTHOR}  Parempi Artikkeli  ${JOURNAL}  2022
    Page Should Not Contain  vol.
    Page Should Not Contain  no.
    Page Should Not Contain  page(s)
    Page Should Not Contain  month:
    Page Should Not Contain  notes:

Reference With Voluntary Info Should Be Added
    Add Reference  ${AUTHOR}  Paras Artikkeli  2022  ${JOURNAL}  3  2  142  5  Muistiin
    Click Button  All references
    Verify Reference  ${AUTHOR}  Paras Artikkeli  ${JOURNAL}  2022  3  2  142  5  Muistiin

Author Should Be Editable
    Add Reference  ${AUTHOR}  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  ${AUTHOR}  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Page Should Contain  Succesfully edited reference!
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Optional Info Should Be Removable
    Add Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}  2  4  10  5  Opiskele
    Click Button  All references
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022  2  4  10  5  Opiskele
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Page Should Contain  Succesfully edited reference!
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Single Reference Should Be Deletable
    Add Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Delete
    Page Should Contain  Succesfully removed reference!

Reference With Voluntary Info Should Be Deletable
    Add Reference  ${AUTHOR}  Paras Artikkeli Ikinä  2002  Aikakauslehti  2  4  10  5  Opiskele
    Click Button  All references
    Verify Reference  ${AUTHOR}  Paras Artikkeli Ikinä  Aikakauslehti  2002  2  4  10  5  Opiskele
    Click Button  Delete
    Page Should Contain  Succesfully removed reference!

All References Should Be Deletable
    Add Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Add Reference  ${AUTHOR}  Parempi Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}
    Verify Reference  ${AUTHOR}  Parempi Artikkeli  ${JOURNAL}  2022
    Page Should Not Contain  vol.
    Page Should Not Contain  no.
    Page Should Not Contain  page(s)
    Page Should Not Contain  month:
    Page Should Not Contain  notes:
    Click Button  Delete
    Page Should Contain  Succesfully removed reference!
    Click Button  Delete
    Page Should Contain  Succesfully removed reference!
    Page Should Contain  No references added yet.

No References Should Display Message
    Go To  ${LIST_REFERENCES}
    Page Should Contain  No references added yet.