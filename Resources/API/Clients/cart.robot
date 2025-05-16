*** Settings ***
Resource            ../base.robot

*** Keywords ***
POST create cart
    ${resp}=        POST On Session     mainSession                  /carts                expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}

POST add to cart
    [Arguments]     ${cartId}           ${productId}                 ${quantity}
    &{payload}=     Create dictionary   product_id=${productId}      quantity=${quantity}
    ${resp}=        POST On Session     mainSession                  /carts/${cartId}       json=${payload}       expected_status=any
    Log             ${resp.content}
    RETURN          ${resp}