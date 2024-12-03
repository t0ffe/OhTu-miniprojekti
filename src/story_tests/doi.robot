*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References



*** Test Cases ***
#Reference can be added with DOI
    #[Tags]  doi
    #Add DOI   ${DOI}
    #Click Button  All references
    #Verify Article Reference   Alex Gaudeul  Do Open Source Developers Respond to Competition? The LATEX Case Study  Review of Network Economics  2007  6  2  None  1

*** Variables ***
${VALID_DOI_ARTICLE_1}  http://doi.org/10.3352/jeehp.2013.10.3
${VALID_DOI_ARTICLE_2}  https://doi.org/10.1111/j.1740-9713.2011.00509.x
${VALID_DOI_ARTICLE_3}  https://rss.onlinelibrary.wiley.com/doi/abs/10.1111/rssa.12993
${VALID_DOI_ARTICLE_4}  https://rss.onlinelibrary.wiley.com/doi/10.1111/j.1740-9713.2012.00573.x
${INVALID_DOI}          10.1234/invalid


*** Test Cases ***
#Valid DOI Should Auto-Fill Form (Article)
    #[Documentation]  
    #Go To  ${NEW_REFERENCE}
    #Input Text  id:doiSearch  ${VALID_DOI_ARTICLE_1}
    #Click Button  xpath://button[text()='Search DOI']
    #Wait Until Page Contains  Reference data found and form populated!
    #Verify Article Auto-Filled Fields 

Invalid DOI Should Show Error
    [Documentation] 
    Go To  ${NEW_REFERENCE}
    Input Text  id:doiSearch  ${INVALID_DOI}
    Click Button  xpath://button[text()='Search DOI']
    Wait Until Page Contains  Could not find reference data for this DOI. Please check the DOI and try again.

*** Keywords ***
Verify Article Auto-Filled Fields
    [Documentation]  
    ${author}=    Get Value    id=author_field_id
    ${title}=     Get Value    id=title_field_id
    ${journal}=   Get Value    id=journal_field_id
    ${year}=      Get Value    id=year_field_id

    Run Keyword If  '${author}' != ''  Log  Author field contains: ${author}
    Run Keyword If  '${title}' != ''  Log  Title field contains: ${title}
    Run Keyword If  '${journal}' != ''  Log  Journal field contains: ${journal}
    Run Keyword If  '${year}' != ''  Log  Year field contains: ${year}