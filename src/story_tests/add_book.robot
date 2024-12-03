*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***

Single Book Reference Should Be Added
    Add Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita   ${PUBLISHER}  ${YEAR}  
    Click Button  All references
    Verify Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita   ${PUBLISHER}  ${YEAR} 

Two Book References Should Be Added
    Add Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien klassikot  ${PUBLISHER}  ${YEAR} 
    Add Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022 
    Click Button  All references
    Verify Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien klassikot  ${PUBLISHER}  ${YEAR} 
    Verify Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien tarinoita  ${PUBLISHER}  2022 
    Page Should Not Contain  vol.
    Page Should Not Contain  no.
    Page Should Not Contain  page(s)
    Page Should Not Contain  month:
    Page Should Not Contain  notes:

Book Reference With Voluntary Info Should Be Added
    Add Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien klassikot  ${PUBLISHER}  2022  3  2  142  5  Muista tämä
    Click Button  All references
    Verify Book Reference   ${AUTHOR}  ${EDITOR}  Latexin ritarien klassikot  ${PUBLISHER}  2022  3  2  142  5  Muista tämä