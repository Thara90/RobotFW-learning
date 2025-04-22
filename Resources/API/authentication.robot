*** Settings ***
Library         RequestsLibrary

*** Keywords ***
Create API Session
    Create Session    mainSession    https://api.practicesoftwaretesting.com    verify=True

Authenticate user
    [Arguments]     ${email}            ${password}
    &{headers}=     Create dictionary   Content-Type=application/json
    &{body}=        Create dictionary   email=${email}                    password=${password}
    ${resp}=        POST On Session     mainSession                       /users/login            headers=${headers}          json=${body}
    Log             ${resp.content}
    RETURN          ${resp}