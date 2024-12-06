*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References




*** Test Cases ***
Conference Date And Location Should Be Valid
    Add Conference Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}
    Click Button  All references
    Verify Conference Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}



Conference Reference With Voluntary Info Should Be Added
    Add Conference Reference   ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  All references
    Verify Conference Reference   ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi



Conference Author Should Be Editable
    Add Conference Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR} 
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR} 
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Conference Reference  Kari Kirjoittelija   LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}



Optional Conference Info Should Be Removable
    Add Conference Reference   ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  Edit
    Clear Element Text  editor
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  pages
    Clear Element Text  address
    Clear Element Text  organization
    Clear Element Text  publisher
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}



Single Conference Reference Should Be Deletable
    Add Conference Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message


Conference Reference With Voluntary Info Should Be Deletable
    Add Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message




All Conference References Should Be Deletable
    Add Conference Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  ${BOOKTITLE}  ${YEAR}
    Add Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  All references
    Verify Conference Reference  ${AUTHOR}  LaTeXin ritarien klassikot  ${BOOKTITLE}  ${YEAR}  ${EDITOR}  4  5  130-159  ${ADDRESS}  5  Ritarit  Helsingin Sanomat  Tärkeä konferenssi
    Click Button  Delete
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.





