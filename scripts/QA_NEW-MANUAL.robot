*** Settings ***
Documentation   BOSS New Application End-to-End Workflow
Resource        ../resources/QA_NEW-MANUAL.resource
Suite Setup     TC01_TS_001 - Open Browser To Login Page
Suite Teardown  Close Browser

*** Test Cases ***
TC01: Login And Navigate To New Application Form
    TC01_TS_002 - Login With Valid Credentials
    TC01_TS_005 - Open BOSS New QA
    TC01_TS_006 - Click Submit Application - Mayor's Permit
    TC01_TS_007 - Click Submit Application - Online
    TC01_TS_008 - Click Proceed - New Application

TC02: Fill Out Guidelines And Documents
    TC02_TS_001 - Step 1: Confirm Guidelines
    TC02_TS_003 - Step 2: Select Nano Enterprise No
    TC02_TS_004 - Step 2: Upload Business Documents

TC03: Fill Business Information
    TC03_TS_001 - Step 3: Fill Business Info

TC04: Fill Business Operation And GIS Pinning
    TC04_TS_001 - Step 4: Business Operations

TC05: Fill Business Activity
    TC05_TS_001 - Step 5: Business Activity

TC06: Other Required Information
    TC06_TS_001 - Step 6: Other Info

TC07: Final Review And Submission
    TC07_TS_001 - Step 7: Submission