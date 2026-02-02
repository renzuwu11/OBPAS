*** Settings ***
Resource        ../resources/new_app.resource
Suite Setup     TC01_TS_001 - Open Browser To Login Page
Suite Teardown  Close Browser

*** Test Cases ***
TC01: Login And Navigate To New Application Form
    TC01_TS_002 - Login With Valid Credentials
    TC01_TS_005 - Open BOSS New QA
    TC01_TS_006 - Click Submit Application - Mayor's Permit
    TC01_TS_007 - Click Submit Application - Online
    TC01_TS_008 - Click Proceed - New Application

TC02: Fill Out New Application Form
    TC02_TS_001 - Step 1: Confirm Guidelines
    TC02_TS_002 - Step 1: Continue
    TC02_TS_003 - Step 2: Select Nano Enterprise No
    TC02_TS_004 - Step 2: Upload Business Documents
    TC02_TS_005 - Step 2: Continue

TC03: Fill Business Information
    TC03_TS_001 - Step 3: Wait For Business Info Form
    TC03_TS_002 - Step 3: Fill Business Type And Name
    TC03_TS_003 - Step 3: Fill Main Office Address
    TC03_TS_004 - Step 3: Fill Contact Information
    TC03_TS_005 - Step 3: Fill Owner Information
    TC03_TS_006 - Step 3: Continue

TC04: Fill Business Operation
    TC04_TS_001 - Step 4: Wait For Business Operations Form
    TC04_TS_002 - Step 4: Fill Business Area and Operation Time
    TC04_TS_003 - Step 4: Fill Business Location
    TC04_TS_004 - Step 4: Continue

TC05: Fill Business Activity
    TC05_TS_001 - Step 5: Wait For Business Activity Form
    TC05_TS_002 - Step 5: Fill Business Activity
    TC05_TS_003 - Step 5: Continue

TC06: Other Required Information
    TC06_TS_001 - Step 6: Wait For Other Required Information Form
    TC06_TS_002 - Step 6: Fill Other Required Information
    TC06_TS_003 - Step 6: Continue

TC07: Summary Page
    TC07_TS_002 - Step 7: Agreement
    TC07_TS_003 - Step 7: Submit Application
    TC07_TS_004 - Step 7: Confirm Application Submitted
