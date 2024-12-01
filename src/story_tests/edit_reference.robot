*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Article Author Should Be Editable
    Add Article Reference  ${AUTHOR}  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Book Author Should Be Editable
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}

Optional Article Info Should Be Removable
    Add Article Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}  2  4  10  5  Opiskele
    Click Button  All references
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022  2  4  10  5  Opiskele
    Click Button  Edit
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Optional Book Info Should Be Removable
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}  2  4  10  5  Opiskele
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}  2  4  10  5  Opiskele
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}

Single Reference Should Be Deletable
    Add Article Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

Reference With Voluntary Info Should Be Deletable
    Add Article Reference  ${AUTHOR}  Paras Artikkeli Ikinä  2002  Aikakauslehti  2  4  10  5  Opiskele
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}  2  4  10  5  Opiskele
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  Paras Artikkeli Ikinä  Aikakauslehti  2002  2  4  10  5  Opiskele
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}  2  4  10  5  Opiskele
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

All References Should Be Deletable
    Add Article Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}    
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}
    Page Should Not Contain  vol.
    Page Should Not Contain  no.
    Page Should Not Contain  page(s)
    Page Should Not Contain  month:
    Page Should Not Contain  notes:
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.

