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

Optional Article Info Should Be Removable
    Add Article Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}  2  4  10  5  Opiskele
    Click Button  All references
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022  2  4  10  5  Opiskele
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022

Single Article Reference Should Be Deletable
    Add Article Reference  Kari Kirjoittelija  Paras Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Article Reference  Kari Kirjoittelija  Paras Artikkeli  ${JOURNAL}  2022
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

Article Reference With Voluntary Info Should Be Deletable
    Add Article Reference  ${AUTHOR}  Paras Artikkeli Ikinä  2002  Aikakauslehti  2  4  10  5  Opiskele
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  Paras Artikkeli Ikinä  Aikakauslehti  2002  2  4  10  5  Opiskele
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

All Article References Should Be Deletable
    Add Article Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Add Article Reference  ${AUTHOR}  Parempi Artikkeli  2022  ${JOURNAL}
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}
    Verify Article Reference  ${AUTHOR}  Parempi Artikkeli  ${JOURNAL}  2022
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



Book Author Should Be Editable
    Add Book Reference   ${AUTHOR}  ${EDITOR}  ${TITLE}  ${PUBLISHER}  ${YEAR} 
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  ${TITLE}  ${PUBLISHER}  ${YEAR}
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  ${TITLE}  ${PUBLISHER}  ${YEAR}

Optional Book Info Should Be Removable
    Add Book Reference  Kari Kirjoittelija  ${EDITOR}  Paras Artikkeli  ${PUBLISHER}  2022  3  2  142  5  Muista tämä
    Click Button  All references
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Paras Artikkeli  ${PUBLISHER}  2022  3  2  142  5  Muista tämä
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Book Reference  Kari Kirjoittelija  ${EDITOR}  Paras Artikkeli  ${PUBLISHER}  2022

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
    Add Book Reference  ${AUTHOR}  ${EDITOR}  ${TITLE}  ${PUBLISHER}  ${YEAR} 
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Parempi Artikkeli  ${PUBLISHER}  2022
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  ${TITLE}  ${PUBLISHER}  ${YEAR} 
    Verify Book Reference  ${AUTHOR}  ${EDITOR}  Parempi Artikkeli  ${PUBLISHER}  2022
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
