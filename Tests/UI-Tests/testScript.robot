*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../../Resources/Pages/loginPage.robot
Resource            ../../Resources/Pages/commonUI.robot

Test Setup         commonUI.Open the browser
Test Teardown      Close Browser    ALL
#robot -d Results Tests/UI-Tests/testScript.robot

*** Test Cases ***
Login with valid credentials
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    loginPage.Click Sign In
    loginPage.Fill login form    customer2@practicesoftwaretesting.com    welcome01