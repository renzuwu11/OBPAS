*** Settings ***
Documentation     BOSS New Application - Polished XPath Version
Library           SeleniumLibrary
Library           Collections
Library           DateTime
Library           OperatingSystem
Library           JSONLibrary
Library           String

*** Variables ***
# --- System & Credentials ---
${BASE_URL}               https://qaqclb.unifysyscontrol.com/
${BROWSER}                chrome
${USERNAME}               izna.mai7@gmail.com
${PASSWORD}               P@ssw0rd

# --- File Paths ---
${RES_PATH}               ${EXECDIR}/resources
${PLACEHOLDER_DIR}        ${RES_PATH}/placeholders
${JSON_DIR}               ${RES_PATH}/json_files
${BARANGAY_STREETS}       ${RES_PATH}/barangay_streets.csv

# --- Step 2: Upload Files ---
${BUS_REG_FILE}           ${PLACEHOLDER_DIR}/1. Proof of Business Registration.png
${CONTRACT_FILE}          ${PLACEHOLDER_DIR}/2. Contract of Lease.jpg
${FRONT_FILE}             ${PLACEHOLDER_DIR}/3. Front View of business location.png
${AREA_FILE}              ${PLACEHOLDER_DIR}/4. Area of business activity.jpg
${LEFT_FILE}              ${PLACEHOLDER_DIR}/5. left.jpg
${RIGHT_FILE}             ${PLACEHOLDER_DIR}/6. right.jpg
${OWNER_ID_FILE}          ${PLACEHOLDER_DIR}/8. Scanned ID of the Owner.jpg

# --- Locators: Global & Navigation ---
${BOSS_IFRAME}            xpath=//iframe[@id='sssi_main']
${BOSS_NEW_QA}            xpath=//a[.//button[contains(.,'BOSS (NEW QA)')]]
${MAYOR_BUTTON_XPATH}     xpath=//h3[contains(text(), 'APPLY FOR MAYOR')]/following::button[1]
${SUBMIT_ONLINE}          xpath=//button[contains(.,'SUBMIT APPLICATION') and contains(@onclick,'application_form_types')]
${PROCEED_NEW}            xpath=//input[@value='PROCEED' and contains(@onclick,'application_form(1)')]

# --- Locators: Step 1 & 2 ---
${GEN_CONFIRM}            xpath=//input[@id='gen-confirm']
${BTN_CONTINUE_GENERAL}   xpath=//button[@id='btn-continue-general']
${NANO_NO}                xpath=//input[@id='nano_enterprise2']
${CHK_PROOF_BUS_REG}      xpath=//input[@id='checkboxsect1']
${CHK_CONTRACT_OF_LEASE}  xpath=//input[@id='checkboxsect3']
${CHK_PHOTOS}             xpath=//input[@id='checkboxsect5']
${PROOF_BUS_REG_INPUT}    xpath=//input[@id='proofBiz']
${CONTRACT_INPUT}         xpath=//input[@id='contractLease']
${FRONT_INPUT}            xpath=//input[@id='sketchPhoto']
${AREA_INPUT}             xpath=//input[@id='sketchPhotoInterior']
${LEFT_INPUT}             xpath=//input[@id='sketchPhotoStreetViewLeft']
${RIGHT_INPUT}            xpath=//input[@id='sketchPhotoStreetViewRight']
${BTN_CONTINUE_FILE}      xpath=//button[@id='btn-continue-documentary']

# --- Locators: Step 3 (Business Info) ---
${RADIO_COOPERATIVE_LABEL}  xpath=//label[@for='sectionb4']
${BUS_NAME_INPUT}           xpath=//input[@id='bname']
${CHK_SAME_AS_BUS_NAME}     xpath=//input[@id='chk_business_name']
${BLDG_NO_INPUT}            xpath=//input[@id='bldgno']
${STREET_INPUT}             xpath=//input[@id='street']
${CITY_DROPDOWN}            xpath=//select[@id='city_id']
${BRGY_DROPDOWN}            xpath=//select[@id='brgy_id']
${EMAIL_INPUT}              xpath=//input[@id='email']
${MOBNO_INPUT}              xpath=//input[@id='mobno']
@{SURNAMES}                 Kim    Lee    Park    Choi    Jung
@{NAMES}                    Seokjin    Junmin    Doyoung    Minjae    Hyunwoo
${SURNAME_INPUT}            xpath=//input[@id='surname']
${GNAME_INPUT}              xpath=//input[@id='gname']
${SEX_MALE_RADIO}           xpath=//input[@id='sex1']
${BTN_CONTINUE_INFORMATION}  xpath=//button[@id='btn-continue-information']

# --- Locators: Step 4 (Operations) ---
${BUSINESS_AREA}          xpath=//input[@id='barea']
${FLOOR_AREA}             xpath=//input[@id='tfarea']
${TIME_FROM}              xpath=//input[@id='time_operation_from']
${TIME_TO}                xpath=//input[@id='time_operation_to']
${SAME_ADDRESS}           xpath=//input[@id='chk_business_add']
${OPEN_MAP_BTN}           xpath=//button[@id='open_map_address_btn']
${MAP_LOAD_BTN}           xpath=//button[@id='load_button']
${MAP_AGREE_BTN}          xpath=//button[contains(.,'I AGREE & CONTINUE')]
${TCT_INPUT}              xpath=//input[@id='tct']
${OWNED_RADIO}            xpath=//input[@id='owned1']
${BTN_CONTINUE_OPERATION}  xpath=//button[@id='btn-continue-operations']

# --- Locators: Step 5 (Activity) ---
${TCI_INPUT}               xpath=//input[@id='tci']
${MAIN_ACTIVITY_DROPDOWN}  xpath=//select[@id='lineofbus0']
${SUB_ACTIVITY_DROPDOWN}   xpath=//select[@id='productionservices0']
${ADD_BIZ_ACTIVITY_BTN}    xpath=//button[@id='add_biz_activity']
${ADD_TO_LIST_BTN}         xpath=//button[@id='add_multiple_button']
${CONFIRM_YES_BTN}         xpath=//button[text()='YES']
${SWAL_CLOSE_BTN}          xpath=//button[contains(@class,'swal2-close')]
${TAX_INCENTIVE_RADIO}     xpath=//input[@id='taxincentives2']
${BUSINESS_ACTIVITY_RADIO}  xpath=//input[@id='busact2']
${BTN_CONTINUE_ACTIVITY}   xpath=//button[@id='btn-continue-activity']

# --- Locators: Step 6 & 7 ---
${OWNERS_ID_INPUT}        id=owners_id
${BTN_CONTINUE_OTHER}     id=btn-continue-other
${CHECK_AGREE_1}          id=check1
${CHECK_AGREE_2}          id=appfic
${SUBMIT_APP_BTN}         xpath=//*[@id='step2']
${FINAL_PROCEED_BTN}      xpath=//button[contains(.,'YES, PROCEED WITH SUBMISSION')]

*** Keywords ***
# --- AUTHENTICATION ---

TC01_TS_001 - Open Browser To Login Page
    Open Browser    about:blank    ${BROWSER}
    Maximize Browser Window
    Go To    ${BASE_URL}
    Wait Until Page Contains Element    xpath=//iframe    30s

TC01_TS_002 - Login With Valid Credentials
    Wait Until Page Contains Element    xpath=//iframe    20s
    Select Frame    xpath=(//iframe)[1]
    Wait Until Element Is Visible    xpath=//input[@id='input_username']    20s
    Input Text       xpath=//input[@id='input_username']    ${USERNAME}
    Click Element    xpath=//button[@id='btn-continue']
    Wait Until Element Is Visible    xpath=//input[@id='input_password']    20s
    Input Text       xpath=//input[@id='input_password']    ${PASSWORD}
    Click Element    xpath=//button[@id='login-btn']
    Unselect Frame

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
    Execute JavaScript    var btn=document.evaluate("${MAYOR_BUTTON_XPATH.replace('xpath=', '')}",document,null,XPathResult.FIRST_ORDERED_NODE_TYPE,null).singleNodeValue;btn.scrollIntoView(true);btn.click();
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
    Unselect Frame
    Wait Until Page Contains Element    xpath=//iframe    10s

# --- STEP 1 & 2 ---

TC02_TS_001 - Step 1: Confirm Guidelines
    Select Frame    ${BOSS_IFRAME}
    Wait Until Element Is Visible    ${GEN_CONFIRM}    20s
    Scroll Element Into View         ${GEN_CONFIRM}
    Click Element                    ${GEN_CONFIRM}
    Click Element                    ${BTN_CONTINUE_GENERAL}
    Sleep    2s

TC02_TS_003 - Step 2: Select Nano Enterprise No
    Wait Until Element Is Visible    ${NANO_NO}    10s
    Click Element                    ${NANO_NO}

TC02_TS_004 - Step 2: Upload Business Documents
    Click Element    ${CHK_PROOF_BUS_REG}
    Choose File      ${PROOF_BUS_REG_INPUT}    ${BUS_REG_FILE}

    Click Element    ${CHK_CONTRACT_OF_LEASE}
    Choose File      ${CONTRACT_INPUT}         ${CONTRACT_FILE}

    Click Element    ${CHK_PHOTOS}
    Choose File      ${FRONT_INPUT}            ${FRONT_FILE}
    Choose File      ${AREA_INPUT}             ${AREA_FILE}
    Choose File      ${LEFT_INPUT}             ${LEFT_FILE}
    Choose File      ${RIGHT_INPUT}            ${RIGHT_FILE}
    Click Element    ${BTN_CONTINUE_FILE}

# --- STEP 3 ---

TC03_TS_001 - Step 3: Fill Business Info
    Load Barangay Streets
    Wait Until Page Contains    Business Information and Registration    20s
    Click Element    ${RADIO_COOPERATIVE_LABEL}

    ${timestamp}=    Get Current Date    result_format=%Y-%m-%d-%H%M%S
    Input Text       ${BUS_NAME_INPUT}    BUSINESS-${timestamp}
    Click Element    ${CHK_SAME_AS_BUS_NAME}

    ${HOUSE_NO}=    Evaluate    random.randint(1, 10)    modules=random
    Input Text      ${BLDG_NO_INPUT}    ${HOUSE_NO}

    Select From List By Value        ${CITY_DROPDOWN}    82
    Sleep    1s

    ${BRGY_LOCAL}=    Get Random Dropdown Label    ${BRGY_DROPDOWN}
    Select From List By Label        ${BRGY_DROPDOWN}    ${BRGY_LOCAL}
    Set Suite Variable               ${BRGY}    ${BRGY_LOCAL}
    ${lookup_key}=    Convert To Lower Case    ${BRGY_LOCAL}
    ${streets}=       Get From Dictionary    ${BARANGAY_STREETS_DICT}    ${lookup_key}
    ${STREET_NAME}=   Evaluate    random.choice(${streets})    modules=random
    Input Text        ${STREET_INPUT}    ${STREET_NAME}

    Input Text       ${EMAIL_INPUT}    izna.mai7@gmail.com
    Clear Element Text                 ${MOBNO_INPUT}
    Input Text       ${MOBNO_INPUT}    09000000000

    ${index}=    Evaluate    random.randint(0, len($SURNAMES)-1)    modules=random
    Input Text   ${SURNAME_INPUT}      ${SURNAMES}[${index}]
    Input Text   ${GNAME_INPUT}        ${NAMES}[${index}]
    Click Element    ${SEX_MALE_RADIO}
    Click Element    ${BTN_CONTINUE_INFORMATION}

# --- STEP 4 ---

TC04_TS_001 - Step 4: Business Operations
    Load Barangay GeoJSONs
    Wait Until Page Contains         Business Operations       15s

    # Standard Inputs
    Input Text                       ${BUSINESS_AREA}          4
    Input Text                       ${FLOOR_AREA}             25

    # Fix for Time Inputs (Using JavaScript to avoid Interaction errors)
    Execute JavaScript    document.getElementById('time_operation_from').value = '06:00';
    Execute JavaScript    document.getElementById('time_operation_to').value = '18:00';

    # Fix for Same Address (JS Click to bypass interception)
    Wait Until Element Is Visible    ${SAME_ADDRESS}           10s
    Execute JavaScript               document.getElementById('chk_business_add').click();

    Sleep                            3s
    Wait Until Element Is Visible    ${OPEN_MAP_BTN}           10s
    Click Element                    ${OPEN_MAP_BTN}
    Wait Until Element Is Visible    ${MAP_LOAD_BTN}           15s
    
    # 1. Stricter Wait: Ensure Google API AND the application's map object are ready
    Wait For Condition    return typeof google !== 'undefined' && typeof window.map !== 'undefined';    timeout=15s
    
    # 2. Buffer: Give the GIS internal scripts 2 seconds to settle
    Sleep    2s

    ${BRGY_KEY}=    Normalize Barangay Name    ${BRGY}
    ${SELECTED_BARANGAY_GEOJSON}=    Get From Dictionary    ${BARANGAY_GEOJSONS}    ${BRGY_KEY}
    ${rand_lat}    ${rand_lon}=    Get Random Point In Barangay    ${SELECTED_BARANGAY_GEOJSON}

    # 3. Enhanced JS Code: Wrap in a try-catch to prevent the test from crashing on JS errors
    ${JS_CODE}=    Catenate    SEPARATOR=
    ...    try {
    ...        var lat = parseFloat("${rand_lat}");
    ...        var lon = parseFloat("${rand_lon}");
    ...        var latLng = new google.maps.LatLng(lat, lon);
    ...        if (window.map) {
    ...            window.map.setCenter(latLng);
    ...            window.map.setZoom(19);
    ...            if (typeof deleteMarkersv2 === "function") { deleteMarkersv2(); }
    ...            if (typeof addMarkerv2 === "function") { addMarkerv2(latLng); }
    ...            $("#clientlatitude").val(lat).trigger("change");
    ...            $("#clientlongitude").val(lon).trigger("change");
    ...            var mObj = window.mapMarker || window.marker;
    ...            if (!mObj || typeof mObj.getPosition !== "function") {
    ...                window.mapMarker = new google.maps.Marker({position: latLng, map: window.map});
    ...                mObj = window.mapMarker;
    ...            }
    ...            if (typeof checkpointinpoly === "function") { checkpointinpoly(mObj); }
    ...            if (typeof checkpointinbrgy === "function") { checkpointinbrgy(mObj); }
    ...        }
    ...    } catch (e) { console.error("GIS Pinning Error: " + e.message); }

    Execute JavaScript    ${JS_CODE}
    Sleep    3s

    # Standard Map buttons
    Scroll Element Into View         ${MAP_LOAD_BTN}
    Wait Until Element Is Enabled    ${MAP_LOAD_BTN}           10s
    Click Element                    ${MAP_LOAD_BTN}

    Wait Until Element Is Visible    ${MAP_AGREE_BTN}          10s
    Click Element                    ${MAP_AGREE_BTN}

    # Final inputs
    Sleep                            2s
    Scroll Element Into View         id=tct
    Input Text                       id=tct                    TCT123

    # Fix for Radio Button
    Scroll Element Into View         id=owned1
    Execute JavaScript               document.getElementById('owned1').click();

    Wait Until Element Is Visible    id=btn-continue-operations    10s
    Click Element                    id=btn-continue-operations

# --- STEP 5 ---

TC05_TS_001 - Step 5: Business Activity
    Wait Until Page Contains    Business Activity    15s
    ${TCI_VAL}=     Evaluate    random.randint(5000, 1000000)    modules=random
    Input Text      ${TCI_INPUT}    ${TCI_VAL}

    Click Element    ${TAX_INCENTIVE_RADIO}
    Click Element    ${BUSINESS_ACTIVITY_RADIO}
    Click Element    ${ADD_BIZ_ACTIVITY_BTN}

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
    Wait Until Element Is Visible    ${CONFIRM_YES_BTN}           10s
    Click Element                    ${CONFIRM_YES_BTN}
    Wait Until Element Is Visible    ${SWAL_CLOSE_BTN}            10s
    Click Element                    ${SWAL_CLOSE_BTN}
    Sleep                                                         2s
    Wait Until Element Is Visible    ${BTN_CONTINUE_ACTIVITY}     10s
    Click Element                    ${BTN_CONTINUE_ACTIVITY}

# --- STEP 6 & 7 ---

TC06_TS_001 - Step 6: Other Info
    Wait Until Page Contains    Other Required Information    15s
    Sleep    2s
    @{radios}=    Create List    xpath=//input[@id='office_purpose2']    xpath=//input[@id='walkin_trans1']    xpath=//input[@id='storage_display1']    xpath=//input[@id='selling_liquor2']    xpath=//input[@id='located_inside2']    xpath=//input[@id='ctc2']    xpath=//input[@id='msme2']    xpath=//input[@id='peza2']    xpath=//input[@id='owner_disabled2']    xpath=//input[@id='employed_disabled2']    xpath=//input[@id='internet_service2']    xpath=//input[@id='security_clearance2']    xpath=//input[@id='cctv_clearance2']    xpath=//input[@id='brgybc2']
    FOR    ${r}    IN    @{radios}
        Click Element    ${r}
    END
    Choose File    ${OWNERS_ID_INPUT}    ${OWNER_ID_FILE}
    Click Element    ${BTN_CONTINUE_OTHER}
    Sleep    2s
    Click Element    ${BTN_CONTINUE_OTHER}
    Wait Until Page Contains    Summary Page    30s

TC07_TS_001 - Step 7: Submission
    Wait Until Element Is Visible    ${CHECK_AGREE_1}    20s
    Scroll Element Into View         ${CHECK_AGREE_1}
    Select Checkbox    ${CHECK_AGREE_1}
    Select Checkbox    ${CHECK_AGREE_2}
    Wait Until Element Is Visible    ${SUBMIT_APP_BTN}    15s
    Execute Javascript    document.getElementById('step2').scrollIntoView(true);
    Execute Javascript    document.getElementById('step2').disabled = false;
    Click Element    ${SUBMIT_APP_BTN}
    Wait Until Element Is Visible    ${FINAL_PROCEED_BTN}    15s
    Click Element    ${FINAL_PROCEED_BTN}
    Sleep    5s
    Run Keyword And Ignore Error    Click Element    xpath=//button[contains(.,'OK')]
    Run Keyword And Ignore Error    Click Element    xpath=//button[contains(@class,'close')]
    Wait Until Page Contains Element    xpath=//h4[contains(text(),'Unified Online Business Permit Application')]    15s
    Sleep                              5s   # allow user to confirm the submission visually

# --- HELPER KEYWORDS ---

Get Random Dropdown Label
    [Arguments]    ${locator}
    ${options}=    Get List Items    ${locator}
    Remove From List    ${options}    0
    ${choice}=     Evaluate    random.choice(${options})    modules=random
    RETURN       ${choice}

Get Non Empty List Items
    [Arguments]    ${locator}
    ${items}=    Get List Items    ${locator}
    Should Not Be Empty    ${items}
    RETURN       ${items}

Normalize Barangay Name
    [Arguments]    ${brgy}
    ${key}=    Evaluate    "${brgy}".strip().replace(" ", "_").lower()
    RETURN    ${key}

Get File Name Without Extension
    [Arguments]    ${path}
    ${basename}=    Evaluate    os.path.splitext(os.path.basename(r"${path}"))[0]    modules=os
    RETURN       ${basename}

Load Barangay Streets
    ${content}=    Get File    ${BARANGAY_STREETS}
    ${rows}=       Evaluate    list(csv.reader($content.splitlines()))    modules=csv
    &{temp_dict}=  Create Dictionary
    FOR    ${row}    IN    @{rows}[1:]
        ${row_length}=    Get Length    ${row}

        # Correct Robot Framework syntax to skip malformed rows
        IF    ${row_length} < 2
            Log    Skipping malformed row: ${row}    WARN
            CONTINUE
        END
        
        # Normalize the Barangay Name (Lowercase) for the Dictionary Key
        ${brgy_name}=      Set Variable    ${row[0]}
        ${brgy_key}=       Convert To Lower Case    ${brgy_name}

        ${streets_raw}=    Set Variable    ${row[1]}
        @{streets_list}=   Split String    ${streets_raw}    ,

        # Clean up the street names (strip spaces)
        ${cleaned_streets}=    Create List
        FOR    ${s}    IN    @{streets_list}
            ${trimmed}=    Strip String    ${s}
            Append To List    ${cleaned_streets}    ${trimmed}
        END

        Set To Dictionary    ${temp_dict}    ${brgy_key}    ${cleaned_streets}
    END
    Set Suite Variable    ${BARANGAY_STREETS_DICT}    ${temp_dict}

Load Barangay GeoJSONs
    &{bar_dict}=    Create Dictionary
    ${files}=    List Files In Directory    ${JSON_DIR}   pattern=*.json
    FOR    ${file}    IN    @{files}
        ${raw}=    Get File Name Without Extension    ${file}
        ${key}=    Evaluate
        ...    "${raw}".strip().lower().replace(" ", "_")
        ${json_text}=    Get File    ${JSON_DIR}/${file}
        ${geojson}=      Evaluate    json.loads($json_text)    modules=json
        Set To Dictionary    ${bar_dict}    ${key}    ${geojson}
    END
    Set Suite Variable    ${BARANGAY_GEOJSONS}    ${bar_dict}

Get Valid Zoning Features
    [Arguments]    ${geojson}
    @{ALLOWED}=    Create List    R-1    R-2    R-3    R-1-A    R-2-A    C-1    C-2    C-3    I-1    I-2    INST    SUDZ    SHZ
    ${features}=    Get From Dictionary    ${geojson}    features
    ${valid}=       Create List
    FOR    ${f}    IN    @{features}
        ${props}=    Get From Dictionary    ${f}    properties
        ${zone}=     Get From Dictionary    ${props}    ZONE
        Run Keyword If    '${zone}' in ${ALLOWED}    Append To List    ${valid}    ${f}
    END
    Should Not Be Empty    ${valid}    No valid zoning polygons found
    RETURN    ${valid}

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
    ${width}=     Evaluate    ${max_x} - ${min_x}
    ${height}=    Evaluate    ${max_y} - ${min_y}
    ${lon}=     Evaluate    random.uniform(${min_x} + (${width}*0.1), ${max_x} - (${width}*0.1))    modules=random
    ${lat}=     Evaluate    random.uniform(${min_y} + (${height}*0.1), ${max_y} - (${height}*0.1))    modules=random
    RETURN    ${lat}    ${lon}