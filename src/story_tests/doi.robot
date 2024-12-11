*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Variables ***
${VALID_DOI_ARTICLE}  http://doi.org/10.3352/jeehp.2013.10.3
${VALID_DOI_BOOK}  https://doi.org/10.1007/978-3-319-55477-8
${INVALID_DOI}  10.1234/invalid


*** Test Cases ***
Valid DOI Should Auto-Fill Form (Article)
    [Documentation]  
    Add DOI  ${VALID_DOI_ARTICLE}
    Wait Until Page Contains  Reference data found and form populated!
    Click Button  Add
    Click Button  All references
    Verify Article Reference  Sun Huh  Revision of the instructions to authors to require a structured abstract, digital object identifier of each reference, and author’s voice recording may increase journal access  Journal of Educational Evaluation for Health Professions  2013  10  None  3  4

Invalid DOI Should Show Error
    [Documentation] 
    Add DOI  ${INVALID_DOI}
    Wait Until Page Contains  Could not find reference data for this DOI. Please check the DOI and try again.

Valid DOI Should Auto-Fill Form (Book)
    [Documentation]  
    Add DOI  ${VALID_DOI_BOOK}
    Wait Until Page Contains  Reference data found and form populated!
    Click Button  Add
    Click Button  All references
    Verify Book Reference  N. Carlo Lauro & Enrica Amaturo & Maria Gabriella Grassia & Biagio Aragona & Marina Marino  Data Science and Social Research  Springer International Publishing  2017

Search Works As Intended
    Add DOI  ${VALID_DOI_ARTICLE}
    Wait Until Page Contains  Reference data found and form populated!
    Click Button  Add
    Add DOI  ${VALID_DOI_BOOK}
    Wait Until Page Contains  Reference data found and form populated!
    Click Button  Add
    Click Button  All references
    Verify Article Reference  Sun Huh  Revision of the instructions to authors to require a structured abstract, digital object identifier of each reference, and author’s voice recording may increase journal access  Journal of Educational Evaluation for Health Professions  2013  10  None  3  4
    Verify Book Reference  N. Carlo Lauro & Enrica Amaturo & Maria Gabriella Grassia & Biagio Aragona & Marina Marino  Data Science and Social Research  Springer International Publishing  2017
    Input Text  id=RefSearch  Carlo Lauro
    Verify Book Reference  N. Carlo Lauro & Enrica Amaturo & Maria Gabriella Grassia & Biagio Aragona & Marina Marino  Data Science and Social Research  Springer International Publishing  2017