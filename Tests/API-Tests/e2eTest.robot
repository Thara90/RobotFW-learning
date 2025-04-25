*** Settings ***
Resource            ../../Resources/API/commonAPI.robot
Resource            ../../Resources/API/authentication.robot
Resource            ../../Resources/API/products.robot

Suite Setup         commonAPI.Create API Session
 #robot -d Results Tests/API-Tests/e2eTest.robot

*** Variables ***
${validPageNumber}      1

*** Test Cases ***
Log In with valid credentials
    ${resp}=            authentication.Authenticate user    customer2@practicesoftwaretesting.com    welcome01
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                      200
    ${json_data}        Set Variable                 ${resp.json()}
    ${access_token}     Set Variable                 ${json_data['access_token']}
    Set Suite Variable  ${access_token}

*** Test Cases ***
Get products with valid page id
    ${resp}=            products.Product details     ${validPageNumber}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}        Set Variable                 ${resp.json()}
    ${product_name}=    Set Variable                 ${json_data}[data][0][name]
    ${product_id}=      Set Variable                 ${json_data}[data][0][id]
    ${product_price}=   Set Variable                 ${json_data}[data][0][price]
    Set Suite Variable  ${product_name}
    Set Suite Variable  ${product_id}
    Set Suite Variable  ${product_price}