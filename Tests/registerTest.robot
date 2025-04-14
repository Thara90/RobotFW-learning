*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../Resources/Pages/loginPage.robot
Resource            ../Resources/Pages/common.robot

 #robot -d Results Tests/registerTest.robot

*** Test Cases ***
Register a new user
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    common.Open the browser
    loginPage.Load registration form
    loginPage.Fill registration form
    loginPage.Submit registration form

