*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
Main Page Should Be Open
    Go To  ${HOME_URL}
    Title Should Be  References app
    Page Should Contain  Here the client can add article type references

Click List All References Link
    Go To  ${HOME_URL}
    Click Link  List all references
    Title Should Be  Reference List

Click Add New Reference List Link
    Go To  ${HOME_URL}
    Click Link  Add new reference
    Page Should Contain  Add a new article type reference

After adding a reference there is one
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Link  View added references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen, 2020.

After adding two references there is two
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Input Text  author  Aki Artikuloija
    Input Text  title  Parempi Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Link  View added references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen, 2020.
    Page Should Contain  Aki Artikuloija. Parempi Artikkeli. Lehtinen, 2022.

*** Settings ***
Resource  resource.robot
Suite Setup      Open And Configure Browser
Suite Teardown   Close Browser
Test Setup       Reset References

*** Test Cases ***
Main Page Should Be Open
    Go To  ${HOME_URL}
    Title Should Be  References app
    Page Should Contain  Here the client can add article type references

Click List All References Link
    Go To  ${HOME_URL}
    Click Link  List all references
    Title Should Be  Reference List

Click Add New Reference List Link
    Go To  ${HOME_URL}
    Click Link  Add new reference
    Page Should Contain  Add a new article type reference

After adding a reference there is one
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Link  View added references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen, 2020.

After adding two references there is two
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Input Text  author  Aki Artikuloija
    Input Text  title  Parempi Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Link  View added references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen, 2020.
    Page Should Contain  Aki Artikuloija. Parempi Artikkeli. Lehtinen, 2022.

After adding three references there is three
    Go To  ${NEW_REFERENCE} 
    Input Text  author  Aki Artikuloija
    Input Text  title  Artikkeli
    Input Text  year  2020
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Input Text  author  Aki Artikuloija
    Input Text  title  Parempi Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Input Text  author  Aki Artikuloija
    Input Text  title  Paras Artikkeli
    Input Text  year  2022
    Input Text  journal  Lehtinen
    Input Text  volume   3
    Input Text  number   2
    Input Text  pages    142
    Input Text  month    2
    Input Text  note     Muistiin
    Click Button  Add
    Page Should Contain  Succesfully added reference!
    Click Link  View added references
    Page Should Contain  Aki Artikuloija. Artikkeli. Lehtinen, 2020.
    Page Should Contain  Aki Artikuloija. Parempi Artikkeli. Lehtinen, 2022.
    Page Should Contain  Aki Artikuloija. Paras Artikkeli. Lehtinen, 2022. 3, 2, 142, 2, Muistiin