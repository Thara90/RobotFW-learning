*** Settings ***
Resource            ../../Resources/API/authentication.robot

Suite Setup    authentication.Create API Session
 #robot -d Results Tests/API-Tests/authenticationTests.robot

*** Test Cases ***
Log In
    ${resp}=     authentication.Authenticate user    customer2@practicesoftwaretesting.com    welcome01
    Should Be Equal As Strings    ${resp.status_code}    200