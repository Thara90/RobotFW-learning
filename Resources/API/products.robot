*** Settings ***
Library         RequestsLibrary

*** Keywords ***
Product details
    [Arguments]     ${pageNumber}
    ${resp}=        GET On Session     mainSession         /products           params=page=${pageNumber}      expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}