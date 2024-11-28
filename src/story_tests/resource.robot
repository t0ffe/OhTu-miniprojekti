*** Settings ***
Library  SeleniumLibrary

*** Variables ***
${SERVER}     localhost:5001
${DELAY}      0.5 seconds
${HOME_URL}   http://${SERVER}
${RESET_URL}  http://${SERVER}/reset_db
${NEW_REFERENCE}  http://${SERVER}/new_reference
${LIST_REFERENCES}  http://${SERVER}/list_references
${EDIT_REFERENCE}  http://${SERVER}/edit_reference
${BROWSER}    chrome
${HEADLESS}   false

*** Keywords ***
Open And Configure Browser
    IF  $BROWSER == 'chrome'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].ChromeOptions()  sys
    ELSE IF  $BROWSER == 'firefox'
        ${options}  Evaluate  sys.modules['selenium.webdriver'].FirefoxOptions()  sys
    END
    IF  $HEADLESS == 'true'
        Set Selenium Speed  0
        Call Method  ${options}  add_argument  --headless
    ELSE
        Set Selenium Speed  ${DELAY}
    END
    Open Browser  browser=${BROWSER}  options=${options}

Reset References
    Go To  ${RESET_URL}

*** Variables ***
${TYPE}  article
${AUTHOR}  Aki Artikuloija
${TITLE}  Artikkeli
${YEAR}  2020
${JOURNAL}  Lehtinen

*** Keywords ***
Add Reference
    [Arguments]  ${author}  ${title}  ${year}  ${journal}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  article
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  year  ${year}
    Input Text  journal  ${journal}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${pages}' != 'None'  Input Text  pages  ${pages}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Reference
    [Arguments]  ${author}  ${title}  ${journal}  ${year}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${journal} (${year})
    Run Keyword If  '${volume}' != 'None'  Page Should Contain  vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain  no. ${number}
    Run Keyword If  '${pages}' != 'None'  Page Should Contain  page(s) ${pages}
    Run Keyword If  '${month}' != 'None'  Page Should Contain  month: ${month}
    Run Keyword If  '${note}' != 'None'  Page Should Contain  notes: ${note}
