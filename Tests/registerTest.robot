*** Settings ***
Documentation       This is basic info about whole test suite
Library             Browser     timeout=0:00:10
 #robot -d Results Tests/registerTest.robot

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
    
    #fill the registration form
    Click               [data-test="register-link"]
    Fill Text           [data-test="first-name"]            Thara
    Fill Text           [data-test="last-name"]             Perera
    Fill Text           [data-test="dob"]                   1990-12-09
    Fill Text           [data-test="street"]                Victoria
    Fill Text           [data-test="postal_code"]           100200
    Fill Text           [data-test="state"]                 Western
    Fill Text           [data-test="city"]                  London
    Select Options By   [data-test="country"]               value                       GB
    Fill Text           [data-test="phone"]                 0771189740
    Fill Text           [data-test="email"]                 testRW@mailinator.com
    Fill Text           [data-test="password"]              Nexus@19901209
    Promise To          Wait For Response                   matcher=**/users/register
    Click               [data-test="register-submit"]
    Wait For All Promises

*** Keywords ***