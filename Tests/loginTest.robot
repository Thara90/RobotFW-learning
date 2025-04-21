*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../Resources/Pages/loginPage.robot
Resource            ../Resources/Pages/common.robot

Test Setup         common.Open the browser
Test Teardown      Close Browser    ALL
 #robot -d Results Tests/loginTest.robot

*** Variables ***

*** Test Cases ***

Login with valid credentials
    [Documentation]     login with valid username and password
    [Tags]              Smoke
    loginPage.Click Sign In
    loginPage.Valid login    customer2@practicesoftwaretesting.com    welcome01    user
 
Login with invalid username
    [Documentation]     login with invalid username
    loginPage.Click Sign In
    loginPage.Invalid login    test@practicesoftwaretesting.com    1234    user

Login with invalid password
    [Documentation]     login with invalid username
    loginPage.Click Sign In
    loginPage.Invalid login    customer2@practicesoftwaretesting.com    1234    user