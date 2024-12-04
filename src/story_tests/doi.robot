*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Variables ***
${VALID_DOI_ARTICLE_1}  http://doi.org/10.3352/jeehp.2013.10.3
${VALID_DOI_ARTICLE_2}  https://doi.org/10.1111/j.1740-9713.2011.00509.x
${VALID_DOI_ARTICLE_3}  https://rss.onlinelibrary.wiley.com/doi/abs/10.1111/rssa.12993
${VALID_DOI_ARTICLE_4}  https://rss.onlinelibrary.wiley.com/doi/10.1111/j.1740-9713.2012.00573.x
${INVALID_DOI}          10.1234/invalid


*** Test Cases ***
Valid DOI Should Auto-Fill Form (Article)
    [Documentation]  
    Add DOI  ${VALID_DOI_ARTICLE_1}
    Wait Until Page Contains  Reference data found and form populated!
    Click Button  Add
    Click Button  All references
    Verify Article Reference  Sun Huh  Revision of the instructions to authors to require a structured abstract, digital object identifier of each reference, and author’s voice recording may increase journal access  Journal of Educational Evaluation for Health Professions  2013  10  None  3  4

Invalid DOI Should Show Error
    [Documentation] 
    Add DOI  ${INVALID_DOI}
    Wait Until Page Contains  Could not find reference data for this DOI. Please check the DOI and try again.

