*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         OperatingSystem

*** Keywords ***
POST payment
    [Arguments]     ${payment_method}
    ${file_name}=   Set Variable                ${payment_method}.json
    ${payload}=     Load Json From File         Resources/API/req-jsons/${file_name}
    Log             ${payload}
    ${resp}=        POST On Session             mainSession                  /payment/check       json=${payload}       expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}