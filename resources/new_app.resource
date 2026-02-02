*** Settings ***
Library           SeleniumLibrary
Library           Collections
Library           DateTime
Library           OperatingSystem
Library           JSONLibrary
Library           String

*** Variables ***
${BASE_URL}       https://qaqclb.unifysyscontrol.com/
${BROWSER}        chrome
${USERNAME}       izna.mai7@gmail.com
${PASSWORD}       P@ssw0rd

# BOSS iframe and buttons
${BOSS_IFRAME}           id=sssi_main
${BOSS_NEW_QA}           xpath=//a[.//button[contains(.,'BOSS (NEW QA)')]]
${MAYOR_BUTTON_XPATH}    //h3[contains(text(), 'APPLY FOR MAYOR')]/following::button[1]
${SUBMIT_ONLINE}         xpath=//button[contains(.,'SUBMIT APPLICATION') and contains(@onclick,'application_form_types')]
${PROCEED_NEW}           xpath=//input[@value='PROCEED' and contains(@onclick,'application_form(1)')]

# Step 1
${GEN_CONFIRM}           xpath=//input[@id='gen-confirm']
${BTN_CONTINUE_GENERAL}  xpath=//button[@id='btn-continue-general']
${NANO_NO}               xpath=//input[@id='nano_enterprise2']

# Step 2 – checkboxes
${CHK_PROOF_BUS_REG}      id=checkboxsect1
${CHK_CONTRACT_OF_LEASE}  id=checkboxsect3
${CHK_PHOTOS}             id=checkboxsect5

# File paths
${FILE_PATH}      C:/Users/admin/Desktop/Placeholders
${BUS_REG_FILE}   ${FILE_PATH}/1. Proof of Business Registration.pdf
${CONTRACT_FILE}  ${FILE_PATH}/2. Contract of Lease.pdf
${FRONT_FILE}     ${FILE_PATH}/3. Front View of business location.png
${AREA_FILE}      ${FILE_PATH}/4. Area of business activity.png
${LEFT_FILE}      ${FILE_PATH}/5. left.png
${RIGHT_FILE}     ${FILE_PATH}/6. right.png

# Step 2 – hidden file inputs
${PROOF_BUS_REG_INPUT}    id=proofBiz
${CONTRACT_INPUT}         id=contractLease
${FRONT_INPUT}            id=sketchPhoto
${AREA_INPUT}             id=sketchPhotoInterior
${LEFT_INPUT}             id=sketchPhotoStreetViewLeft
${RIGHT_INPUT}            id=sketchPhotoStreetViewRight
${BTN_CONTINUE_FILE}      id=btn-continue-documentary

# Step 3 – business information anf registration
${RADIO_COOPERATIVE_LABEL}      xpath=//label[@for='sectionb4']
${BUS_NAME_INPUT}               id=bname
${TRADE_NAME_INPUT}             id=tname
${CHK_SAME_AS_BUS_NAME}         id=chk_business_name
${CITY_QC_VALUE}                82
${EMAIL_ADDR}                   izna.mai7@gmail.com
${MOBILE_NO}                    09000000000
@{SURNAMES}                     Kim    Lee    Park    Choi    Jung
@{NAMES}                        Seokjin    Junmin    Doyoung    Minjae    Hyunwoo
${BTN_CONTINUE_INFORMATION}     id=btn-continue-information
${BARANGAY_STREETS}              C:\\Users\\admin\\Desktop\\Placeholders\\barangay_streets.csv

# Step 4 – business operations
${BARANGAY_PATH}                C:\\Users\\admin\\Desktop\\JSON FILES\\JSON FILES
${BUSINESS_AREA}                id=barea
${FLOOR_AREA}                   id=tfarea
${TIME_FROM}                    id=time_operation_from
${TIME_TO}                      id=time_operation_to
${SAME_ADDRESS}                 id=chk_business_add
${SEARCH_BOX}                   id=autocomplete-search-input
${OPEN_MAP_BTN}                 id=open_map_address_btn
${MAP_LOAD_BTN}                 id=load_button
${MAP_AGREE_BTN}                xpath=//button[contains(.,'I AGREE & CONTINUE')]
${BTN_CONTINUE_OPERATION}       id=btn-continue-operations
${MIN_DISTANCE_METERS}          5

#Step 5 - business activity
# @{TCI}
${MAIN_ACTIVITY_DROPDOWN}       id=lineofbus0
${SUB_ACTIVITY_DROPDOWN}        id=productionservices0
${ADD_BIZ_ACTIVITY_BTN}         id=add_biz_activity
${ADD_TO_LIST_BTN}              id=add_multiple_button
${CONFIRM_YES_BTN}              xpath=//button[text()='YES']
${SWAL_CLOSE_BTN}               xpath=//button[contains(@class,'swal2-close')]
${TAX_INCENTIVE_RADIO}          id=taxincentives2
${BUSINESS_ACTIVITY_RADIO}      id=busact2
${BTN_CONTINUE_ACTIVITY}        id=btn-continue-activity

*** Keywords ***
TC01_TS_001 - Open Browser To Login Page
    Open Browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    xpath=//iframe    30s

TC01_TS_002 - Login With Valid Credentials
    Wait Until Page Contains Element    xpath=//iframe    20s
    Select Frame    xpath=(//iframe)[1]
    Wait Until Element Is Visible    id=input_username    20s
    Input Text    id=input_username    ${USERNAME}
    Click Element    id=btn-continue
    Wait Until Element Is Visible    id=input_password    20s
    Input Text    id=input_password    ${PASSWORD}
    Click Element    id=login-btn
    Unselect Frame

TC01_TS_003 - Verify Successful Login
    Wait Until Keyword Succeeds    60s    2s    TC01_TS_004 - Select BOSS Module Frame

TC01_TS_004 - Select BOSS Module Frame
    Wait Until Page Contains Element    ${BOSS_IFRAME}    20s
    Select Frame    ${BOSS_IFRAME}

TC01_TS_005 - Open BOSS New QA
    Unselect Frame
    Wait Until Page Contains Element    ${BOSS_IFRAME}    30s
    Select Frame                        ${BOSS_IFRAME}

    Wait Until Keyword Succeeds    30s    2s    Element Should Be Visible    ${BOSS_NEW_QA}
    Scroll Element Into View       ${BOSS_NEW_QA}
    Click Element                  ${BOSS_NEW_QA}
    Sleep    5s

TC01_TS_006 - Click Submit Application - Mayor's Permit
    Wait Until Element Is Visible    ${MAYOR_BUTTON_XPATH}    30s
    Execute JavaScript    var btn=document.evaluate("${MAYOR_BUTTON_XPATH}",document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue;btn.scrollIntoView(true);btn.click();
    Sleep    2s

TC01_TS_007 - Click Submit Application - Online
    Unselect Frame
    Select Frame    ${BOSS_IFRAME}

    Wait Until Element Is Visible    ${SUBMIT_ONLINE}    20s
    Click Element    ${SUBMIT_ONLINE}

TC01_TS_008 - Click Proceed - New Application
    Wait Until Element Is Visible    ${PROCEED_NEW}    10s
    Click Element    ${PROCEED_NEW}

    Sleep    3s
    Log    Current URL: ${CURDIR}
    ${handles}=    Get Window Handles
    Log    Window handles: ${handles}

    Unselect Frame
    Wait Until Page Contains Element    xpath=//iframe    10s

TC02_TS_001 - Step 1: Confirm Guidelines
    Select Frame    ${BOSS_IFRAME}
    Wait Until Element Is Visible    ${GEN_CONFIRM}    20s
    Scroll Element Into View         ${GEN_CONFIRM}
    Click Element                    ${GEN_CONFIRM}

TC02_TS_002 - Step 1: Continue
    Wait Until Element Is Visible    ${BTN_CONTINUE_GENERAL}    10s
    Click Element                    ${BTN_CONTINUE_GENERAL}
    Sleep    2s

TC02_TS_003 - Step 2: Select Nano Enterprise No
    Wait Until Element Is Visible    ${NANO_NO}    10s
    Click Element                    ${NANO_NO}
    Sleep    1s

TC02_TS_004 - Step 2: Upload Business Documents
    # Proof of Business Registration
    Click Element    ${CHK_PROOF_BUS_REG}
    Wait Until Element Is Visible    ${PROOF_BUS_REG_INPUT}    10s
    Choose File    ${PROOF_BUS_REG_INPUT}    ${BUS_REG_FILE}

    # Contract of Lease
    Click Element    ${CHK_CONTRACT_OF_LEASE}
    Wait Until Element Is Visible    ${CONTRACT_INPUT}    10s
    Choose File    ${CONTRACT_INPUT}    ${CONTRACT_FILE}

    # Photos (single checkbox enables all)
    Click Element    ${CHK_PHOTOS}

    Choose File    ${FRONT_INPUT}    ${FRONT_FILE}
    Choose File    ${AREA_INPUT}     ${AREA_FILE}
    Choose File    ${LEFT_INPUT}     ${LEFT_FILE}
    Choose File    ${RIGHT_INPUT}    ${RIGHT_FILE}

TC02_TS_005 - Step 2: Continue
    Wait Until Element Is Visible    ${BTN_CONTINUE_FILE}    5s
    Click Element                    ${BTN_CONTINUE_FILE}

TC03_TS_001 - Step 3: Wait For Business Info Form
    Load Barangay Streets
    Wait Until Page Contains    Business Information and Registration    10s

TC03_TS_002 - Step 3: Fill Business Type And Name
    Wait Until Element Is Visible    ${RADIO_COOPERATIVE_LABEL}    10s
    Scroll Element Into View         ${RADIO_COOPERATIVE_LABEL}
    Click Element                    ${RADIO_COOPERATIVE_LABEL}

    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d-%H%M%S
    ${business_name}=    Set Variable    BUSINESS-${timestamp}
    Input Text    ${BUS_NAME_INPUT}    ${business_name}
    Click Element    id=chk_business_name

Get Random Dropdown Label
    [Arguments]    ${locator}
    ${options}=    Get List Items    ${locator}
    Remove From List    ${options}    0
    Should Not Be Empty    ${options}
    ${choice}=     Evaluate    random.choice(${options})    modules=random
    [Return]       ${choice}

Load Barangay Streets
    ${content}=    Get File    ${BARANGAY_STREETS}
    ${rows}=       Evaluate    list(csv.reader($content.splitlines()))    modules=csv
    &{temp_dict}=  Create Dictionary
    FOR    ${row}    IN    @{rows}[1:]
        # Use name EXACTLY as it is in the CSV (which now matches the Web)
        ${brgy_name}=      Set Variable    ${row[0]}
        ${streets_raw}=    Set Variable    ${row[1]}
        @{streets_list}=   Split String    ${streets_raw}    ,
        Set To Dictionary    ${temp_dict}    ${brgy_name}    ${streets_list}
    END
    Set Suite Variable    ${BARANGAY_STREETS_DICT}    ${temp_dict}

TC03_TS_003 - Step 3: Fill Main Office Address
    # 1. Fill Building No
    ${HOUSE_NO}=    Evaluate    random.randint(1, 10)    modules=random
    Wait Until Element Is Visible    id=bldgno    5s
    Input Text                      id=bldgno    ${HOUSE_NO}

    # 2. Select City (Always Quezon City)
    Wait Until Element Is Visible    id=city_id    10s
    Select From List By Value        id=city_id    82
    Sleep    1s  # Let the Barangay list load

    # 3. Select Barangay
    Wait Until Element Is Visible    id=brgy_id    10s
    ${BRGY_LOCAL}=    Get Random Dropdown Label    id=brgy_id
    Select From List By Label        id=brgy_id    ${BRGY_LOCAL}
    Set Suite Variable               ${BRGY}    ${BRGY_LOCAL}

    # 4. NOW look up the street from the loaded dictionary
    ${streets}=       Get From Dictionary    ${BARANGAY_STREETS_DICT}    ${BRGY_LOCAL}
    ${STREET_NAME}=   Evaluate    random.choice(${streets}).strip()    modules=random
    Input Text        id=street    ${STREET_NAME}

TC03_TS_004 - Step 3: Fill Contact Information
    Wait Until Element Is Visible    id=email    10s
    Input Text    id=email    ${EMAIL_ADDR}
    Wait Until Element Is Visible    id=mobno    10s
    Clear Element Text               id=mobno
    Input Text                       id=mobno    ${MOBILE_NO}

TC03_TS_005 - Step 3: Fill Owner Information
    ${index}=    Evaluate    random.randint(0, len($SURNAMES)-1)    modules=random
    ${surname}=  Get From List    ${SURNAMES}    ${index}
    ${gname}=    Get From List    ${NAMES}       ${index}

    Wait Until Element Is Visible    id=surname                      10s
    Input Text                       id=surname      ${surname}
    Input Text                       id=gname        ${gname}
    Click Element                    id=sex1

TC03_TS_006 - Step 3: Continue
    Wait Until Element Is Visible    ${BTN_CONTINUE_INFORMATION}     10s
    Click Element                    ${BTN_CONTINUE_INFORMATION}

Get File Name Without Extension
    [Arguments]    ${path}
    ${basename}=    Evaluate    os.path.splitext(os.path.basename(r"${path}"))[0]    modules=os
    [Return]       ${basename}

Load Barangay GeoJSONs
    &{bar_dict}=    Create Dictionary
    ${files}=    List Files In Directory    ${BARANGAY_PATH}    pattern=*.json

    FOR    ${file}    IN    @{files}
        ${raw}=    Get File Name Without Extension    ${file}

        ${key}=    Evaluate
        ...    "${raw}".strip().lower().replace(" ", "_")

        ${json_text}=    Get File    ${BARANGAY_PATH}\\${file}
        ${geojson}=      Evaluate    json.loads(r'''${json_text}''')    modules=json

        Set To Dictionary    ${bar_dict}    ${key}    ${geojson}
    END

    Set Suite Variable    ${BARANGAY_GEOJSONS}    ${bar_dict}

TC04_TS_001 - Step 4: Wait For Business Operations Form
    Load Barangay GeoJSONs
    Wait Until Page Contains    Business Operations    5s

TC04_TS_002 - Step 4: Fill Business Area and Operation Time
    Input Text                       ${BUSINESS_AREA}          4
    Input Text                       ${FLOOR_AREA}             25

    # From time → 6:00 AM
    Wait Until Element Is Visible    ${TIME_FROM}              5s
    Click Element                    ${TIME_FROM}
    Input Text                       ${TIME_FROM}              06:00
    Press Keys                       ${TIME_FROM}              A

    # To time → 6:00 PM
    Wait Until Element Is Visible    ${TIME_TO}                5s
    Click Element                    ${TIME_TO}
    Input Text                       ${TIME_TO}                06:00
    Press Keys                       ${TIME_TO}                P

Get Valid Zoning Features
    [Arguments]    ${geojson}

    @{ALLOWED_ZONES}=    Create List
    ...    R-1    R-2    R-3    R-1-A    R-2-A
    ...    C-1    C-2    C-3
    ...    I-1    I-2
    ...    INST    SUDZ    SHZ

    ${features}=    Get From Dictionary    ${geojson}    features
    ${valid}=       Create List

    FOR    ${f}    IN    @{features}
        ${props}=    Get From Dictionary    ${f}    properties
        ${zone}=     Get From Dictionary    ${props}    ZONE
        Run Keyword If    '${zone}' in @{ALLOWED_ZONES}    Append To List    ${valid}    ${f}
    END

    Should Not Be Empty    ${valid}    No valid zoning polygons found

    [Return]    ${valid}

Get Random Point In Barangay
    [Arguments]    ${geojson}
    ${valid_features}=    Get Valid Zoning Features    ${geojson}
    ${feature}=           Evaluate    random.choice(${valid_features})    modules=random
    ${geometry}=          Get From Dictionary    ${feature}    geometry
    ${coords_list}=       Get From Dictionary    ${geometry}    coordinates
    ${polygon}=           Set Variable    ${coords_list[0]}

    ${min_x}=    Evaluate    min([p[0] for p in ${polygon}])
    ${max_x}=    Evaluate    max([p[0] for p in ${polygon}])
    ${min_y}=    Evaluate    min([p[1] for p in ${polygon}])
    ${max_y}=    Evaluate    max([p[1] for p in ${polygon}])

    # Calculate a 10% buffer to ensure movement is significant
    ${width}=     Evaluate    ${max_x} - ${min_x}
    ${height}=    Evaluate    ${max_y} - ${min_y}

    # Pick a point in the polygon
    ${lon}=     Evaluate    random.uniform(${min_x} + (${width}*0.1), ${max_x} - (${width}*0.1))    modules=random
    ${lat}=     Evaluate    random.uniform(${min_y} + (${height}*0.1), ${max_y} - (${height}*0.1))    modules=random

    [Return]    ${lat}    ${lon}

Normalize Barangay Name
    [Arguments]    ${brgy}
    ${key}=    Evaluate    "${brgy}".strip().replace(" ", "_").lower()
    [Return]    ${key}

TC04_TS_003 - Step 4: Fill Business Location
    Click Element                    ${SAME_ADDRESS}
    Sleep                            5s

    Click Element                    ${OPEN_MAP_BTN}
    Wait Until Element Is Visible    ${MAP_LOAD_BTN}    10s
    Sleep                            2s

    # Generate random coordinates
    ${BRGY_KEY}=    Normalize Barangay Name    ${BRGY}
    ${SELECTED_BARANGAY_GEOJSON}=    Get From Dictionary    ${BARANGAY_GEOJSONS}    ${BRGY_KEY}
    ${rand_lat}    ${rand_lon}=    Get Random Point In Barangay    ${SELECTED_BARANGAY_GEOJSON}

    Log    Attempting to force pin at: ${rand_lat}, ${rand_lon}

    # Clean JavaScript: Single line to prevent "Unexpected token" errors
    ${JS_CODE}=    Catenate    SEPARATOR=
    ...    var lat = parseFloat("${rand_lat}");
    ...    var lon = parseFloat("${rand_lon}");
    ...    var latLng = new google.maps.LatLng(lat, lon);
    ...    if (window.map) {
    ...        window.map.setCenter(latLng);
    ...        window.map.setZoom(19);
    ...        if (typeof deleteMarkersv2 === "function") { deleteMarkersv2(); }
    ...        if (typeof addMarkerv2 === "function") { addMarkerv2(latLng); }
    ...        $("#clientlatitude").val(lat).trigger("change");
    ...        $("#clientlongitude").val(lon).trigger("change");
    ...        var mObj = window.mapMarker || window.marker;
    ...        if (!mObj || typeof mObj.getPosition !== "function") {
    ...            window.mapMarker = new google.maps.Marker({position: latLng, map: window.map});
    ...            mObj = window.mapMarker;
    ...        }
    ...        if (typeof checkpointinpoly === "function") { checkpointinpoly(mObj); }
    ...        if (typeof checkpointinbrgy === "function") { checkpointinbrgy(mObj); }
    ...    }

    Execute JavaScript    ${JS_CODE}

    # Sleep so you can see the pin move and the distance update
    Sleep    8s

    # Click Load Button to confirm location
    Scroll Element Into View         ${MAP_LOAD_BTN}
    Wait Until Element Is Enabled    ${MAP_LOAD_BTN}    5s
    Click Element                    ${MAP_LOAD_BTN}
    Sleep                            2s

    # Agree & Continue
    Wait Until Element Is Visible    ${MAP_AGREE_BTN}    10s
    Click Element                    ${MAP_AGREE_BTN}
    Sleep                            3s

    # Fill TCT (title) number
    Scroll Element Into View         id=clientzoningdescription
    Input Text                       id=tct    TCT123

TC04_TS_004 - Step 4: Continue
    Wait Until Element Is Visible    id=owned1                   10s
    Click Element                    id=owned1
    Sleep                            1s

    Wait Until Element Is Visible    id=btn-continue-operations    10s
    Click Element                    id=btn-continue-operations

TC05_TS_001 - Step 5: Wait For Business Activity Form
    Wait Until Page Contains         Business Activity             5s
    Log                              Business Activity form is visible, proceeding to fill data

Get Non Empty List Items
    [Arguments]    ${locator}
    ${items}=    Get List Items    ${locator}
    Should Not Be Empty    ${items}
    [Return]       ${items}

TC05_TS_002 - Step 5: Fill Business Activity
    Wait Until Element Is Visible    id=tci    20s
    Input Text                       id=tci    10000

    Click Element                    ${TAX_INCENTIVE_RADIO}
    Click Element                    ${BUSINESS_ACTIVITY_RADIO}
    Click Element                    ${ADD_BIZ_ACTIVITY_BTN}

    Wait Until Element Is Visible    ${MAIN_ACTIVITY_DROPDOWN}    10s
    ${main_options}=                 Wait Until Keyword Succeeds    10s    1s    Get Non Empty List Items    ${MAIN_ACTIVITY_DROPDOWN}
    ${main_choice}=                  Evaluate    random.choice(${main_options}[1:])    modules=random
    Select From List By Label        ${MAIN_ACTIVITY_DROPDOWN}    ${main_choice}

    Wait Until Element Is Visible    ${SUB_ACTIVITY_DROPDOWN}     10s
    ${sub_options}=                  Wait Until Keyword Succeeds    10s    1s    Get Non Empty List Items    ${SUB_ACTIVITY_DROPDOWN}
    ${sub_choice}=                   Evaluate    random.choice(${sub_options}[1:])    modules=random
    Select From List By Label        ${SUB_ACTIVITY_DROPDOWN}     ${sub_choice}

    Wait Until Page Contains Element    xpath=//input[contains(@class,'psic-checkbox-item')]    10s

    ${psic_items}=    Get WebElements
    ...    xpath=//input[contains(@class,'psic-checkbox-item') and not(ancestor::div[contains(@class,'checkbox-all')])]

    ${count}=    Get Length    ${psic_items}

    Run Keyword If    ${count} == 0    Fail    No PSIC items available to select

    IF    ${count} == 1
        Click Element    ${psic_items}[0]
    END

    IF    ${count} > 1
        ${indices}=    Evaluate    random.sample(range(${count}), 2)    modules=random
        FOR    ${i}    IN    @{indices}
            Click Element    ${psic_items}[${i}]
        END
    END

    Click Element                    ${ADD_TO_LIST_BTN}
    Wait Until Element Is Visible    ${CONFIRM_YES_BTN}    10s
    Click Element                    ${CONFIRM_YES_BTN}
    Wait Until Element Is Visible    ${SWAL_CLOSE_BTN}     10s
    Click Element                    ${SWAL_CLOSE_BTN}
    Sleep                            2s

TC05_TS_003 - Step 5: Continue
    Wait Until Element Is Visible    ${BTN_CONTINUE_ACTIVITY}     10s
    Click Element                    ${BTN_CONTINUE_ACTIVITY}

TC06_TS_001 - Step 6: Wait For Other Required Information Form
    Wait Until Page Contains         Other Required Information             5s
    Log                              Other Required Information form is visible, proceeding to fill data

TC06_TS_002 - Step 6: Fill Other Required Information
    Sleep            2s
    Click Element    id=office_purpose2
    Click Element    id=walkin_trans1
    Click Element    id=storage_display1
    Click Element    id=selling_liquor2
    Click Element    id=located_inside2
    Click Element    id=ctc2
    Click Element    id=msme2
    Click Element    id=peza2
    Click Element    id=owner_disabled2
    Click Element    id=employed_disabled2
    Click Element    id=internet_service2
    Click Element    id=security_clearance2
    Click Element    id=cctv_clearance2
    Click Element    id=brgybc2

    Scroll Element Into View    id=owners_id
    Choose File                 id=owners_id    ${FILE_PATH}/8. Scanned ID of the Owner.png

TC06_TS_003 - Step 6: Continue
    Scroll Element Into View        id=btn-continue-other
    Click Element                   id=btn-continue-other
    Sleep                           2s
    Click Element                   id=btn-continue-other
    Wait Until Page Contains        Summary Page       40s
    Log                             Proceeded to Summary Page

TC07_TS_002 - Step 7: Agreement
    Wait Until Element Is Visible   xpath=//input[@id='check1']     40s
    Scroll Element Into View        id=check1
    Execute JavaScript              document.getElementById('check1').checked = true
    Scroll Element Into View        id=appfic
    Execute JavaScript              document.getElementById('appfic').checked = true

TC07_TS_003 - Step 7: Submit Application
    # Step 7: Submit Application
    Scroll Element Into View        id=check1
    Click Element                   id=check1
    Scroll Element Into View        id=appfic
    Click Element                   id=appfic

    # Wait until the button is visible and enabled
    Wait Until Keyword Succeeds    15s    1s    Run Keyword And Ignore Error    Element Should Be Visible    id=step2
    Wait Until Keyword Succeeds    15s    1s    Run Keyword And Ignore Error    Element Should Be Enabled    id=step2

    # Ensure button is visible and clickable using JS
    Execute Javascript             document.getElementById('step2').scrollIntoView(true);
    Execute Javascript             document.getElementById('step2').disabled = false;

    # Now click the Submit Application button
    Click Element                  id=step2

    # Confirm submission modal
    Wait Until Element Is Visible    xpath=//button[contains(.,'YES, PROCEED WITH SUBMISSION')]    10s
    Click Element                    xpath=//button[contains(.,'YES, PROCEED WITH SUBMISSION')]
    Sleep                             10s

    # Wait for success modal
    Wait Until Element Is Visible    xpath=//div[@id='modal_new_online']    10s

    # Close the modal safely
    Run Keyword And Ignore Error    Click Element    xpath=//button[contains(.,'OK')]
    Run Keyword And Ignore Error    Click Element    xpath=//button[contains(@class,'close')]

TC07_TS_004 - Step 7: Confirm Application Submitted
    # Wait until redirected to the Unified Online Business Permit Application page
    Wait Until Page Contains Element    xpath=//h4[contains(text(),'Unified Online Business Permit Application')]    10s
    Sleep                              5s   # allow user to confirm the submission visually