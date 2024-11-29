*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Author Should Be Editable
    Add Reference  ${AUTHOR}  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  ${AUTHOR}  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
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
    Wait until Page Contains Element  css=div.success-message
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Single Reference Should Be Deletable
    Add Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

Reference With Voluntary Info Should Be Deletable
    Add Reference  ${AUTHOR}  Paras Artikkeli Ikinä  2002  Aikakauslehti  2  4  10  5  Opiskele
    Click Button  All references
    Verify Reference  ${AUTHOR}  Paras Artikkeli Ikinä  Aikakauslehti  2002  2  4  10  5  Opiskele
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

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
    Wait until Page Contains Element  css=div.success-message
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.

