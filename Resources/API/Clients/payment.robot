*** Settings ***
Resource            ../base.robot

*** Keywords ***
POST payment
    [Arguments]         ${payment_method}                   ${paymentDetailsParams}
    ${file_name}=       Set Variable                        payment.json
    ${payload}=         Load Json From File                 Resources/API/req-jsons/${file_name}
    #Update the parameter dynamically
    Set To Dictionary   ${payload}                          payment_method=${payment_method}
    FOR    ${key}    ${value}    IN    &{paymentDetailsParams}
        Set To Dictionary    ${payload['payment_details']}    ${key}=${value}
    END
    Log                 ${payload}
    ${resp}=            POST On Session                     mainSession                             /payment/check       json=${payload}       expected_status=any
    RETURN              ${resp}