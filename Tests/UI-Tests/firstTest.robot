*** Settings ***
Documentation       This is basic info about whole test suite
Library             Browser     timeout=0:00:10
 #robot -d Results Tests/UI-Tests/firstTest.robot

*** Variables ***
${browser}      chromium
${url}          https://practicesoftwaretesting.com/auth/login

*** Test Cases ***
Register a new user
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke

    #open the browser
    Log                         Starting the test case
    New Browser                 ${browser}    headless=${False}
    New Page                    ${url}

    Fill Text               [data-test="email"]            customer@practicesoftwaretesting.com
    Fill Text               [data-test="password"]         welcome01
    Click                   [data-test="login-submit"]
    Wait For Condition      Url                            should end with    /account