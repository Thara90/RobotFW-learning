*** Settings ***
Library         RequestsLibrary

*** Keywords ***
GET search
    [Arguments]     ${searchQuery}
    ${resp}=        GET On Session     mainSession         /products           params=q=${searchQuery}      expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}