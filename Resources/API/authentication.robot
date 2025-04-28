*** Settings ***
Library         RequestsLibrary

*** Keywords ***
POST authenticate
    [Arguments]     ${email}            ${password}
    &{payload}=     Create dictionary   email=${email}      password=${password}
    ${resp}=        POST On Session     mainSession         /users/login              json=${payload}       expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}