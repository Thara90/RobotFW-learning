*** Settings ***
Resource            ../../Resources/API/authentication.robot
Resource            ../../Resources/API/commonAPI.robot

Suite Setup         commonAPI.Create API Session
 #robot -d Results Tests/API-Tests/authenticationTests.robot

*** Test Cases ***
Log In with valid credentials
    ${resp}=     authentication.Authenticate user    customer2@practicesoftwaretesting.com    welcome01
    Should Be Equal As Strings                       ${resp.status_code}                      200

Log In with invalid credentials
    ${resp}=     authentication.Authenticate user    customer2@practicesoftwaretesting.com    incorrectPwd
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                      401
    ${json_data}    Set Variable                     ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['error']}                    Unauthorized
