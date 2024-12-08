*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***

Single Master's thesis Reference Should Be Added
    Add Master's thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify Master's thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}



Master's thesis Reference With Voluntary Info Should Be Added
    Add Master's thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  All references
    Verify Master's thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu



Master's thesis Author Should Be Editable
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Master's thesis Reference  Kari Kirjoittelija  ${TITLE}  ${SCHOOL}  ${YEAR}



Optional Master's thesis Info Should Be Removable
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  address
    Clear Element Text  month
    Clear Element Text  note
    Clear Element Text  thesis_type
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Master's thesis Reference  Kari Kirjoittelija  ${TITLE}  ${SCHOOL}  ${YEAR}



Single Master's thesis Reference Should Be Deletable
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message



Master's thesis Reference With Voluntary Info Should Be Deletable
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message



All Master's thesis References Should Be Deletable
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Mastersthesis  Helsinki  2  Tärkeä Gradu
    Add Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Maisterintutkielma  Turku  4  Erittäin Tärkeä Gradu
    Click Button  All references
    Verify Master's thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  Maisterintutkielma  Turku  4  Erittäin Tärkeä Gradu
    Click Button  Delete
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.





