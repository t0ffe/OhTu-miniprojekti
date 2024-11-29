*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Main Page Should Be Open
    Go To  ${HOME_URL}
    Title Should Be  References App
    Page Should Contain  This is an app for the client to add different types of references and inspect them in BibTex- format
    Page Should Contain  The client can also edit and remove added references
    Page Should Contain  The app is created by LateXin Ritarit during the course Ohjelmistotuotanto (5 op)
    Page Should Contain  Creators:
    Page Should Contain  Tofelius Laakso
    Page Should Contain  Heidi Tapani
    Page Should Contain  Daniel Kalske
    Page Should Contain  Emilia Koponen
    Page Should Contain  Matias Ilola
    Page Should Contain  Kety Kuusaru

All References Link Should Be Clickable
    Go To  ${HOME_URL}
    Click Link  All references
    Title Should Be  Reference List

New Reference Link Should Be Clickable
    Go To  ${HOME_URL}
    Click Link  New reference
    Page Should Contain  Add new 
    Page Should Contain  type reference

No References Should Display Message
    Go To  ${LIST_REFERENCES}
    Page Should Contain  No references added yet.