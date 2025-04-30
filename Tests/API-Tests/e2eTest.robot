*** Settings ***
Resource            ../../Resources/API/commonAPI.robot
Resource            ../../Resources/API/authentication.robot
Resource            ../../Resources/API/products.robot
Resource            ../../Resources/API/cart.robot
Resource            ../../Resources/API/payment.robot

Suite Setup         commonAPI.Create API Session
#robot -d Results Tests/API-Tests/e2eTest.robot

*** Variables ***
${validPageNumber}      1
${productQuantity}      1
${payment_method}       buy-now-pay-later

*** Test Cases ***
Log In with valid credentials
    ${resp}=            authentication.POST authenticate   customer2@practicesoftwaretesting.com    welcome01
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                      200
    ${json_data}        Set Variable                 ${resp.json()}
    ${access_token}     Set Variable                 ${json_data['access_token']}
    Set Suite Variable  ${access_token}

Select a product
    ${resp}=            products.GET products    ${validPageNumber}
    Run Keyword And Continue On Failure              Should Be Equal As Strings               ${resp.status_code}                       200
    ${json_data}        Set Variable                 ${resp.json()}
    ${product_name}=    Set Variable                 ${json_data}[data][0][name]
    ${product_id}=      Set Variable                 ${json_data}[data][0][id]
    ${product_price}=   Set Variable                 ${json_data}[data][0][price]
    Set Suite Variable  ${product_name}
    Set Suite Variable  ${product_id}
    Set Suite Variable  ${product_price}

Create cart ID
    ${resp}=            cart.POST create cart
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}     201
    ${json_data}        Set Variable                 ${resp.json()}
    ${cart_id}          Set Variable                 ${json_data['id']}
    Set Suite Variable  ${cart_id}

Add to cart
    ${resp}=            cart.POST add to cart         ${cart_id}                                ${product_id}               ${productQuantity}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         200
    ${json_data}        Set Variable                 ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${json_data['result']}      item added or updated

Check out with a payment method
    ${resp}=            payment.POST payment         ${payment_method}                          6
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         200
    ${json_data}        Set Variable                 ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${json_data['message']}     Payment was successful