*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../Resources/Pages/registerPage.robot
Resource            ../Resources/Pages/loginPage.robot
Resource            ../Resources/Pages/common.robot

Suite Setup     common.Open the browser
 #robot -d Results Tests/registerTest.robot

*** Test Cases ***
Register a new user and verify login
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    registerPage.Load registration form
    ${userDetails}     registerPage.Fill registration form
    registerPage.Submit registration form
    loginPage.Login to system

