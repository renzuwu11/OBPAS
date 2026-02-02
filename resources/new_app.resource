*** Settings ***
Library    SeleniumLibrary
Library    Collections

*** Keywords ***

Open Browser To Login Page
    [Documentation]    Opens browser, maximizes, and navigates to base URL
    Open Browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    xpath=//iframe    30s

Login With Valid Credentials
    [Documentation]    Performs the login using username and password
    Wait Until Page Contains Element    xpath=//iframe    20s
    # Select first iframe for login
    Select Frame    xpath=(//iframe)[1]

    Wait Until Element Is Visible    id=input_username    20s
    Input Text    id=input_username    ${USERNAME}

    Wait Until Element Is Enabled    id=btn-continue    10s
    Click Element    id=btn-continue

    Wait Until Element Is Visible    id=input_password    20s
    Input Text    id=input_password    ${PASSWORD}

    Wait Until Element Is Enabled    id=login-btn    10s
    Click Element    id=login-btn

    Unselect Frame

Verify Successful Login
    Wait Until Keyword Succeeds    60s    2s    Select BOSS Module Frame

Select BOSS Module Frame
    Wait Until Page Contains Element    id=sssi_main    20s
    Select Frame    id=sssi_main
    Log    Selected iframe: sssi_main

Open BOSS New QA
    Wait Until Element Is Visible    xpath=//a[.//button[contains(.,'BOSS (NEW QA)')]]    20s
    Execute JavaScript    document.evaluate("//a[.//button[contains(.,'BOSS (NEW QA)')]]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue.click();
    Sleep    2s

Click Submit Application - Mayor's Permit
    Sleep    2s
    Wait Until Element Is Visible    xpath=//h3[contains(text(), "APPLY FOR MAYOR")]/following::button[1]    30s
    Execute JavaScript    var btn = document.evaluate("//h3[contains(text(), 'APPLY FOR MAYOR')]/following::button[1]", document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue; btn.scrollIntoView(true); btn.click();
    Sleep    1s

Click Submit Application - Online
    Sleep    1s
    Wait Until Element Is Visible    xpath=//button[contains(.,'SUBMIT APPLICATION') and contains(@onclick,'application_form_types')]    10s
    Click Button    xpath=//button[contains(.,'SUBMIT APPLICATION') and contains(@onclick,'application_form_types')]
    Sleep    1s

Click Proceed - New Application
    Sleep    1s
    Wait Until Element Is Visible    xpath=//input[@value='PROCEED' and contains(@onclick,'application_form(1)')]    10s
    Click Button    xpath=//input[@value='PROCEED' and contains(@onclick,'application_form(1)')]
    Sleep    1s