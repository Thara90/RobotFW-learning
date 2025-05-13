*** Settings ***
Library             Browser     timeout=0:00:20
Library    String

*** Variables ***
${locatorItemPrice}             [data-test="line-price"]
${btnProceedToCheckout}         [data-test="proceed-1"]


*** Keywords ***

Assert total price
    [Arguments]    ${selectedProductsPrices}
    ${expectedTotalPrice}=  Calculate expected total price      ${selectedProductsPrices}
    Sleep    5s
    ${productCount}                         Get Element Count           ${locatorItemPrice}
    ${actualTotalPrice}=    Set Variable    0
    FOR    ${i}    IN RANGE    1    ${productCount + 1}
        ${itemPrice}                        Get Text                    xpath=(//span[@data-test='product-price'])[${i}]
        ${itemPrice}=    Replace String    ${itemPrice}    $    ${EMPTY}
        ${itemPrice}=    Convert To Number    ${itemPrice}
        ${actualTotalPrice}=   Evaluate    ${actualTotalPrice} + ${itemPrice}
    END
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${actualTotalPrice}    ${expectedTotalPrice}

Calculate expected total price
    [Arguments]    ${selectedPproductsPrices}
    ${expectedTotalPrice}=    Evaluate    sum(${selectedPproductsPrices})
    RETURN  ${expectedTotalPrice}
