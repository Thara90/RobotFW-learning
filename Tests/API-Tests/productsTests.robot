*** Settings ***
Resource            ../../Resources/API/products.robot
Resource            ../../Resources/API/commonAPI.robot

Suite Setup         commonAPI.Create API Session
 #robot -d Results Tests/API-Tests/productsTests.robot

*** Variables ***
@{product_names}=    Create List
${validPageNumber}      1
${invalidPageNumber}    1000

*** Test Cases ***
Get products with valid page id
    ${resp}=        products.GET products        ${validPageNumber}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}    Set Variable                     ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['current_page']}              ${validPageNumber}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['from']}                      1
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['to']}                        9
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['last_page']}                 6
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['per_page']}                  9
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['total']}                     50
    FOR    ${item}    IN    @{json_data['data']}
           ${name}=   Set Variable    ${item['name']}
           Append To List    ${product_names}    ${name}
    END
    Log     ${product_names}

Get products with invalid page id
    ${resp}=        products.GET products         ${invalidPageNumber}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}    Set Variable                     ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${json_data['current_page']}              ${invalidPageNumber}
    ${length}=      Get Length                       ${json_data['data']}
    Should Be Equal As Integers                      ${length}                                 0