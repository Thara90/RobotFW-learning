*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         OperatingSystem

*** Keywords ***
POST payment
    [Arguments]     ${payment_method}
    ${file_name}=   Set Variable                ${payment_method}.json
    ${payload}=     Get File                    Resources/API/${file_name}
    ${resp}=        POST On Session             mainSession                  /payment/check       json=${payload}       expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}