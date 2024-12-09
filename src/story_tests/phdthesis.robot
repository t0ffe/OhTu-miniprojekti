*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***


Single PhD Thesis Reference Should Be Added
    Add PhD Thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify PhD Thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}



Two PhD Thesis References Should Be Added
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Add PhD Thesis Reference  Antti Anttinen  Tohtorin väitöskirja  Tampereen yliopisto  2022
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Verify PhD Thesis Reference  Antti Anttinen  Tohtorin väitöskirja  Tampereen yliopisto  2022



PhD Thesis Reference With Voluntary Info Should Be Added
    Add PhD Thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  All references
    Verify PhD Thesis Reference   ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja



PhD Thesis Author Should Be Editable
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify PhD Thesis Reference  Kari Kirjoittelija  ${TITLE}  ${SCHOOL}  ${YEAR}



Optional PhD Thesis Info Should Be Removable
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Clear Element Text  address
    Clear Element Text  month
    Clear Element Text  note
    Clear Element Text  thesis_type
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify PhD Thesis Reference  Kari Kirjoittelija  ${TITLE}  ${SCHOOL}  ${YEAR}



Single PhD Thesis Reference Should Be Deletable
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message



PhD Thesis Reference With Voluntary Info Should Be Deletable
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message



All PhD Thesis References Should Be Deletable
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Helsinki  2  Tärkeä Väitöskirja
    Add PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Turku  4  Erittäin Tärkeä Väitöskirja
    Click Button  All references
    Verify PhD Thesis Reference  ${AUTHOR}  ${TITLE}  ${SCHOOL}  ${YEAR}  PhD Thesis  Turku  4  Erittäin Tärkeä Väitöskirja
    Click Button  Delete
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.





