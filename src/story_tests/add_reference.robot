*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Single Aritcle Reference Should Be Added
    Add Article Reference  ${AUTHOR}  ${TITLE}  ${YEAR}  ${JOURNAL}
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  ${TITLE}  ${JOURNAL}  ${YEAR}

Single Book Reference Should Be Added
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}

Two References Should Be Added
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

Article Reference With Voluntary Info Should Be Added
    Add Article Reference  ${AUTHOR}  Paras Artikkeli  2022  ${JOURNAL}  3  2  142  5  Muistiin
    Click Button  All references
    Verify Article Reference  ${AUTHOR}  Paras Artikkeli  ${JOURNAL}  2022  3  2  142  5  Muistiin

Book Reference With Voluntary Info Should Be Added
    Add Book Reference  ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${YEAR}  3  2  142  5  Muistiin 
    Click Button  All references
    Verify Book Reference  ${AUTHOR}  Latexin ritarien tarinoita  ${PUBLISHER}  ${EDITOR}  ${YEAR}  3  2  142  5  Muistiin 