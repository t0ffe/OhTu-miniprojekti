*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
Reference can be added with DOI
    #[Tags]  doi
    #Add DOI   ${DOI}
    #Click Button  All references
    #Verify Article Reference   Alex Gaudeul  Do Open Source Developers Respond to Competition? The LATEX Case Study  Review of Network Economics  2007  6  2  None  1