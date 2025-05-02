*** Settings ***
Library         RequestsLibrary

*** Keywords ***
POST authenticate
    [Arguments]                             ${email}                ${password}
    &{payload}=                             Create dictionary       email=${email}      password=${password}
    ${resp}=                                POST On Session         mainSession         /users/login              json=${payload}       expected_status=any
    Log                                     ${resp.content}
    RETURN                                  ${resp}

Authenticate And Set Token
    [Arguments]                             ${email}                ${password}
    &{payload}=                             Create dictionary       email=${email}      password=${password}
    ${resp}=                                POST On Session         mainSession         /users/login              json=${payload}       expected_status=any
    Run Keyword And Continue On Failure     Should Be Equal As Strings                  ${resp.status_code}        200
    ${json_data}                            Set Variable            ${resp.json()}
    ${access_token}=                        Set Variable            ${json_data['access_token']}
    Set Suite Variable                      ${access_token}