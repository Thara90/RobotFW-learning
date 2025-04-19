*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../Resources/Pages/loginPage.robot
Resource            ../Resources/Pages/common.robot

Suite Setup     common.Open the browser
 #robot -d Results Tests/loginTest.robot

*** Variables ***

*** Test Cases ***

Successful login
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    loginPage.Click Sign In
    loginPage.Login to system   customer@practicesoftwaretesting.com    welcome01

