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
${AUTHOR}  Aki Artikuloija
${TITLE}  Mahtava Gradu
${YEAR}  2020
${JOURNAL}  Lehtinen
${EDITOR}  Antti Auttaja
${PUBLISHER}  LateXin Ritarit
${BOOKTITLE}  Latexin konferenssitapahtuma
${ORGANIZATION}  Helsingin yliopisto
${ADDRESS}  Helsinki
${SCHOOL}  University of Helsinki

*** Keywords ***
Add Article Reference
    [Arguments]  ${author}  ${title}  ${year}  ${journal}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  article
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  journal  ${journal}
    Input Text  year  ${year}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${pages}' != 'None'  Input Text  pages  ${pages}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Article Reference
    [Arguments]  ${author}  ${title}  ${journal}  ${year}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${journal},  (${year}).
    Run Keyword If  '${volume}' != 'None'  Page Should Contain  vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain  no. ${number}
    Run Keyword If  '${pages}' != 'None'  Page Should Contain  page(s) ${pages}
    Run Keyword If  '${month}' != 'None'  Page Should Contain  month: ${month}
    Run Keyword If  '${note}' != 'None'  Page Should Contain  notes: ${note}

Add Book Reference
    [Arguments]  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  book
    Input Text  author  ${author}
    Input Text  editor  ${editor}
    Input Text  title  ${title}
    Input Text  publisher  ${publisher}
    Input Text  year  ${year}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${pages}' != 'None'  Input Text  pages  ${pages}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Book Reference
    [Arguments]  ${author}  ${editor}  ${title}  ${publisher}  ${year}  ${volume}=None  ${number}=None  ${pages}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${publisher}. (${year}).  
    Run Keyword If  '${volume}' != 'None'  Page Should Contain  vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain  no. ${number}
    Run Keyword If  '${pages}' != 'None'  Page Should Contain  page(s) ${pages}
    Run Keyword If  '${month}' != 'None'  Page Should Contain  month: ${month}
    Run Keyword If  '${note}' != 'None'  Page Should Contain  notes: ${note}


Add Conference Reference
    [Arguments]  ${author}  ${title}  ${booktitle}  ${year}  ${editor}=None  ${volume}=None  ${number}=None  ${pages}=None  ${address}=None  ${month}=None  ${organization}=None  ${publisher}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  conference
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  booktitle  ${booktitle}
    Input Text  year  ${year}
    Run Keyword If  '${editor}' != 'None'  Input Text  editor  ${editor}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${pages}' != 'None'  Input Text  pages  ${pages}
    Run Keyword If  '${address}' != 'None'  Input Text  address  ${address}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${organization}' != 'None'  Input Text  organization  ${organization}
    Run Keyword If  '${publisher}' != 'None'  Input Text  publisher  ${publisher}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Conference Reference
    [Arguments]  ${author}  ${title}  ${booktitle}  ${year}  ${editor}=None  ${volume}=None  ${number}=None  ${pages}=None  ${address}=None  ${month}=None  ${organization}=None  ${publisher}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. In ${booktitle} (${year}).
    Run Keyword If  '${editor}' != 'None'  Page Should Contain  editor: ${editor}
    Run Keyword If  '${volume}' != 'None'  Page Should Contain  vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain  no. ${number}
    Run Keyword If  '${pages}' != 'None'  Page Should Contain  page(s) ${pages}
    Run Keyword If  '${address}' != 'None'  Page Should Contain  address: ${address}
    Run Keyword If  '${month}' != 'None'  Page Should Contain  month: ${month}
    Run Keyword If  '${organization}' != 'None'  Page Should Contain  organization: ${organization}
    Run Keyword If  '${publisher}' != 'None'  Page Should Contain  publisher: ${publisher}
    Run Keyword If  '${note}' != 'None'  Page Should Contain  notes: ${note}

Add DOI
    [Arguments]  ${doi}
    Go To  ${NEW_REFERENCE}
    Input Text  id=doiSearch  ${doi}
    Click Button  xpath=//button[contains(text(), 'Search DOI')]

Verify BibTeX Output
    [Arguments]  ${expected_bibtex}
    ${actual_bibtex}=  Get Text  xpath=//div[@class="export-page"]/pre
    Should Be Equal As Strings  ${actual_bibtex}  ${expected_bibtex}


Add Booklet Reference
    [Arguments]  ${author}  ${title}  ${howpublished}  ${address}  ${year}  ${editor}=None  ${volume}=None  ${number}=None  ${organization}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  booklet
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  howpublished  ${howpublished }
    Input Text  address  ${address}
    Input Text  year  ${year}
    Run Keyword If  '${editor}' != 'None'  Input Text  editor  ${editor}
    Run Keyword If  '${volume}' != 'None'  Input Text  volume  ${volume}
    Run Keyword If  '${number}' != 'None'  Input Text  number  ${number}
    Run Keyword If  '${organization}' != 'None'  Input Text  organization  ${organization}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Booklet Reference
    [Arguments]  ${author}  ${title}  ${howpublished}  ${address}  ${year}  ${editor}=None  ${volume}=None  ${number}=None  ${organization}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${howpublished}. ${address}. (${year}).  
    Run Keyword If  '${editor}' != 'None'  Page Should Contain   editor:  ${editor}
    Run Keyword If  '${volume}' != 'None'  Page Should Contain   vol. ${volume}
    Run Keyword If  '${number}' != 'None'  Page Should Contain   no.  ${number}
    Run Keyword If  '${organization}' != 'None'  Page Should Contain   organization:  ${organization}
    Run Keyword If  '${month}' != 'None'  Page Should Contain   month:  ${month}
    Run Keyword If  '${note}' != 'None'  Page Should Contain   notes:  ${note}


Add Master's thesis Reference
    [Arguments]  ${author}  ${title}  ${school}  ${year}  ${thesis_type}=None  ${address}=None  ${month}=None  ${note}=None
    Go To  ${NEW_REFERENCE}
    Select From List By Label  id:reference-type  mastersthesis
    Input Text  author  ${author}
    Input Text  title  ${title}
    Input Text  school  ${school}
    Input Text  year  ${year}
    Run Keyword If  '${thesis_type}' != 'None'  Input Text  thesis_type  ${thesis_type}
    Run Keyword If  '${address}' != 'None'  Input Text  address  ${address}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}
    Click Button  Add

Verify Master's thesis Reference
    [Arguments]  ${author}  ${title}  ${school}  ${year}  ${thesis_type}=None  ${address}=None  ${month}=None  ${note}=None
    Page Should Contain  ${author}. ${title}. ${school}. ${year}.
    Run Keyword If  '${thesis_type}' != 'None'  Input Text  thesis_type  ${thesis_type}
    Run Keyword If  '${address}' != 'None'  Input Text  address  ${address}
    Run Keyword If  '${month}' != 'None'  Input Text  month  ${month}
    Run Keyword If  '${note}' != 'None'  Input Text  note  ${note}








