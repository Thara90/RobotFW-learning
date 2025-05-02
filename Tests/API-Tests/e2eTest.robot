*** Settings ***
Resource            ../../Resources/API/commonAPI.robot
Resource            ../../Resources/API/authentication.robot
Resource            ../../Resources/API/products.robot
Resource            ../../Resources/API/cart.robot
Resource            ../../Resources/API/payment.robot
Resource            ../../Resources/API/invoice.robot

Suite Setup         Suite Setup - Init Session And Auth
#robot -d Results Tests/API-Tests/e2eTest.robot

*** Variables ***
${validPageNumber}              1
${productQuantity}              1
#Acceptable values for payment_method : buy-now-pay-later, credit-card
${payment_method}               credit-card

*** Test Cases ***
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
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         201
    ${json_data}        Set Variable                 ${resp.json()}
    ${cart_id}          Set Variable                 ${json_data['id']}
    Set Suite Variable  ${cart_id}

Add to cart
    ${resp}=            cart.POST add to cart        ${cart_id}                                ${product_id}               ${productQuantity}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         200
    ${json_data}        Set Variable                 ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${json_data['result']}      item added or updated

Check out with a ${payment_method} payment method
    ${paymentDetailsParams}=                         Create Payment Details Dictionary          ${payment_method}
    ${resp}=            payment.POST payment         ${payment_method}                          ${paymentDetailsParams}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         200
    ${json_data}        Set Variable                 ${resp.json()}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${json_data['message']}     Payment was successful

Generate invoice
    ${paymentDetailsParams}=                         Create Payment Details Dictionary          ${payment_method}
    ${resp}=            invoice.POST invoice         ${payment_method}                          ${cart_id}                  ${paymentDetailsParams}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${resp.status_code}         201
    ${json_data}        Set Variable                 ${resp.json()}
    ${invoice_number}   Set Variable                 ${json_data['invoice_number']}
    Set Suite Variable  ${invoice_number}
    Run Keyword And Continue On Failure              Should Be Equal As Strings                 ${json_data['total']}       ${product_price}



*** Keywords ***
Suite Setup - Init Session And Auth
    commonAPI.Create API Session
    authentication.Authenticate And Set Token    customer2@practicesoftwaretesting.com    welcome01

Create Payment Details Dictionary
    [Arguments]    ${payment_type}
    IF    "${payment_type}" == "buy-now-pay-later"
        ${details}=    Create Dictionary    monthly_installments=3
    ELSE IF    "${payment_type}" == "credit-card"
        ${details}=    Create Dictionary    credit_card_number=0000-0000-0000-0000    expiration_date=12/2028    cvv=123    card_holder_name=jack howe
    END
    RETURN    ${details}