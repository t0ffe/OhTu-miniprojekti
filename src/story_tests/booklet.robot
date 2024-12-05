*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Single Booklet Reference Should Be Added
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}  
    Click Button  All references
    Verify Booklet Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}  

Two Booklet References Should Be Added
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}  
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  2022 
    Click Button  All references
    Verify Booklet Reference   ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR} 
    Verify Booklet Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  2022 
    Page Should Not Contain  editor:
    Page Should Not Contain  vol.
    Page Should Not Contain  no.
    Page Should Not Contain  organization:
    Page Should Not Contain  month:
    Page Should Not Contain  notes:

Booklet Reference With Voluntary Info Should Be Added
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  2022  ${EDITOR}  3  2  Ritarit  5  Muista tämä
    Click Button  All references
    Verify Booklet Reference   ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  2022  ${EDITOR}  3  2  Ritarit  5  Muista tämä

Booklet Author Should Be Editable
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR} 
    Click Button  All references
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR} 
    Click Button  Edit
    Input Text  author  Kari Kirjoittelija
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Booklet Reference  Kari Kirjoittelija   LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR} 

Optional Booklet Info Should Be Removable
    Add Booklet Reference   ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  2022  ${EDITOR}  3  2  Ritarit  5  Muista tämä
    Click Button  All references
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  2022  ${EDITOR}  3  2  Ritarit  5  Muista tämä
    Click Button  Edit
    Clear Element Text  editor
    Clear Element Text  volume
    Clear Element Text  number
    Clear Element Text  organization
    Clear Element Text  month
    Clear Element Text  note
    Click Button  Edit
    Wait until Page Contains Element  css=div.success-message
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien klassikot  Presented at the LaTeX Conference  Helsinki, FIN  2022

Single Booklet Reference Should Be Deletable
    Add Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  All references
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

Booklet Reference With Voluntary Info Should Be Deletable
    Add Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  All references
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message

All Booklet References Should Be Deletable
    Add Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  All references
    Verify Booklet Reference  ${AUTHOR}  LaTeXin ritarien tarinoita  Presented at the LaTeX Conference  Helsinki, FIN  ${YEAR}
    Click Button  Delete
    Wait until Page Contains Element  css=div.success-message
    Page Should Contain  No references added yet.