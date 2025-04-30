*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         OperatingSystem
Library    Collections

*** Keywords ***
POST payment
    [Arguments]         ${payment_method}                   ${installments}
    ${file_name}=       Set Variable                        ${payment_method}.json
    ${payload}=         Load Json From File                 Resources/API/req-jsons/${file_name}
    #Update the parameter dynamically
    Set To Dictionary   ${payload['payment_details']}       monthly_installments=${installments}
    Log                 ${payload}
    ${resp}=            POST On Session                     mainSession                             /payment/check       json=${payload}       expected_status=any
    RETURN              ${resp}