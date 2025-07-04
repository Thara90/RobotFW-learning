*** Settings ***
Resource            ../../Resources/API/base.robot
Resource            ../../Resources/API/Clients/authentication.robot

Suite Setup         base.Create API Session
 #robot -d Results Tests/API-Tests/authenticationTests.robot

*** Test Cases ***
Log In with valid credentials
    ${resp}=     authentication.POST authenticate    customer2@practicesoftwaretesting.com    welcome01
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                      200
    ${json_data}    Set Variable                     ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['token_type']}               bearer

Log In with invalid credentials
    ${resp}=     authentication.POST authenticate   customer2@practicesoftwaretesting.com    incorrectPwd
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                      401
    ${json_data}    Set Variable                     ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['error']}                    Unauthorized
