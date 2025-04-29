*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary

*** Keywords ***
POST payment
    [Arguments]     ${payment_method}
    ${file_name}=   Set Variable    ${payment_method}.json
    #${json_string}= Get File        payloads/${file_name}
    #${payload}=     Evaluate        json.loads("""${json_string}""")    json
    &{payload}=     Create dictionary
    ${resp}=        POST On Session     mainSession                  /payment/check       json=${payload}       expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}