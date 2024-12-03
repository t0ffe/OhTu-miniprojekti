*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***


Book Author Should Be Editable
    Add Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR} 
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}

Optional Book Info Should Be Removable
    Add Book Reference  Kari Kirjoittelija  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022  3  2  142  5  Muista tämä
    Click Button  All references
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022  3  2  142  5  Muista tämä
    Click Button  Edit
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022

Single Book Reference Should Be Deletable
    Add Book Reference  Kari Kirjoittelija  ${EDITOR}  Paras Artikkeli  ${PUBLISHER}  2022
    Click Button  All references
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Paras Artikkeli  ${PUBLISHER}  2022
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

Book Reference With Voluntary Info Should Be Deletable
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Paras Artikkeli Ikinä  ${PUBLISHER}  2002  2  4  10  5  Opiskele
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  Paras Artikkeli Ikinä  ${PUBLISHER}  2002  2  4  10  5  Opiskele
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

All Book References Should Be Deletable
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.