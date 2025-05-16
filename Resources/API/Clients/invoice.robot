*** Settings ***
Resource            ../base.robot

*** Keywords ***
POST invoice
    [Arguments]         ${payment_method}                   ${cart_id}                              ${paymentDetailsParams}
    &{headers}=         Create Dictionary                   Authorization=Bearer ${access_token}
    ${file_name}=       Set Variable                        invoice.json
    ${payload}=         Load Json From File                 Resources/API/req-jsons/${file_name}
    #Update the parameter dynamically
    Set To Dictionary   ${payload}                          cart_id=${cart_id}
    Set To Dictionary   ${payload}                          payment_method=${payment_method}
    FOR    ${key}    ${value}    IN    &{paymentDetailsParams}
        Set To Dictionary    ${payload['payment_details']}    ${key}=${value}
    END
    Log                 ${payload}
    ${resp}=            POST On Session                     mainSession                             /invoices       headers=${headers}      json=${payload}       expected_status=any
    RETURN              ${resp}