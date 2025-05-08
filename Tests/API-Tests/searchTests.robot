*** Settings ***
Resource            ../../Resources/API/search.robot
Resource            ../../Resources/API/commonAPI.robot

Suite Setup         commonAPI.Create API Session
 #robot -d Results Tests/API-Tests/searchTests.robot

*** Variables ***
@{product_names}=       Create List
${validProductName}     Pliers
${invalidProductName}   1234

*** Test Cases ***
Get search results with valid product name
    ${resp}=        search.GET search                ${validProductName}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}    Set Variable                     ${resp.json()}
    ${length}=      Get Length                       ${json_data['data']}
    Should Be True                                   ${length} > 0
    FOR    ${item}    IN    @{json_data['data']}
           ${name}=   Set Variable    ${item['name']}
           Run Keyword And Continue On Failure       Should Match Regexp               ${name}                                   .*${validProductName}.*
           Append To List    ${product_names}    ${name}
    END
    Log     ${product_names}

Get search results with invalid product name
    ${resp}=        search.GET search                ${invalidProductName}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}    Set Variable                     ${resp.json()}
    ${length}=      Get Length                       ${json_data['data']}
    Should Be Equal As Integers                      ${length}                                0