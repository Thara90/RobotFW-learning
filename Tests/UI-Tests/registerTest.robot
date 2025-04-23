*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../../Resources/Pages/registerPage.robot
Resource            ../../Resources/Pages/loginPage.robot
Resource            ../../Resources/Pages/usersPage.robot
Resource            ../../Resources/Pages/commonUI.robot

Test Setup      commonUI.Open the browser
Test Teardown   Delete Created User
 #robot -d Results Tests/UI-Tests/registerTest.robot

*** Test Cases ***
Register a new user and verify login
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    registerPage.Load registration form
    ${email}    ${password}=     registerPage.Fill registration form
    registerPage.Submit registration form
    loginPage.Valid login   ${email}    ${password}     user
    Set Suite Variable    ${email}
    Set Suite Variable    ${password}
    loginPage.Logout

*** Keywords ***
Delete Created User
    loginPage.Valid login   admin@practicesoftwaretesting.com    welcome01    admin
    usersPage.Load users
    usersPage.Delete users    ${email}

