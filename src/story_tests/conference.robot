*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
#Conference Date And Location Should Be Valid
    #Add Conference Reference   ${AUTHOR}  ${EDITOR}  Latexin konferenssitapahtuma  ${PUBLISHER}  ${YEAR}  2023-12-10  Helsinki  ${PUBLISHER}  
    #Click Button  All references
    #Verify Conference Reference   ${AUTHOR}  ${EDITOR}  Latexin konferenssitapahtuma  ${PUBLISHER}  ${YEAR}  2023-12-10  Helsinki  ${PUBLISHER}  
    #Korjan tämän