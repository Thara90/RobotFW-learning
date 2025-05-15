*** Settings ***
Library             Browser     timeout=0:00:20
Library             String
Resource            ../Helpers/helperBase.robot

*** Variables ***
${locatorItemPrice}                 [data-test="line-price"]
${btnProceedToCheckout_1}           [data-test="proceed-1"]
${btnProceedToCheckout_2}           [data-test="proceed-2"]
${msgProceed}                       xpath=//p[@class='ng-star-inserted']
${lblUserName}                      [data-test="nav-menu"]
${btnProceedToCheckout_3}           [data-test="proceed-3"]
${lblBilingAddress}                 xpath=//h3[normalize-space(text())='Billing Address']
${lblBPayment}                      xpath=//h3[normalize-space(text())='Payment']
${txtStreet}                        [data-test="street"]
${txtCity}                          [data-test="city"]
${txtState}                         [data-test="state"]
${txtCountry}                       [data-test="country"]
${txtpostalCode}                    [data-test="postal_code"]

*** Keywords ***

Assert total price
    [Arguments]    ${selectedProductsPrices}
    ${expectedTotalPrice}=  Calculate expected total price                  ${selectedProductsPrices}
    Sleep    5s
    ${productCount}                         Get Element Count               ${locatorItemPrice}
    ${actualTotalPrice}=                    Set Variable                    0
    FOR    ${i}    IN RANGE    1    ${productCount + 1}
        ${itemPrice}                        Get Text                        xpath=(//span[@data-test='product-price'])[${i}]
        ${itemPrice}=                       Replace String                  ${itemPrice}        $         ${EMPTY}
        ${itemPrice}=                       Convert To Number               ${itemPrice}
        ${actualTotalPrice}=                Evaluate                        ${actualTotalPrice} + ${itemPrice}
    END
    Run Keyword And Continue On Failure     Should Be Equal As Numbers      ${actualTotalPrice}    ${expectedTotalPrice}

Calculate expected total price
    [Arguments]    ${selectedPproductsPrices}
    ${expectedTotalPrice}=                  Evaluate                        sum(${selectedPproductsPrices})
    RETURN  ${expectedTotalPrice}

Click proceed to checkout step 1
    Click                                   ${btnProceedToCheckout_1}
    ${userName}                             Get Text                    ${lblUserName}
    ${userName}=                            Strip String                ${userName}
    Run Keyword And Continue On Failure     Get Text                    ${msgProceed}    should be      Hello ${userName}, you are already logged in. You can proceed to checkout.

Click proceed to checkout step 2
    Click                                   ${btnProceedToCheckout_2}
    Run Keyword And Continue On Failure     Wait For Elements State     ${lblBilingAddress}    visible

Fill billing address
    ${firstName}    ${lastName}    ${dateOfBirth}    ${street}    ${postalCode}    ${city}    ${state}    ${countryCode}    ${phoneNum}    ${email}    ${password}=    Make random registration data

    Fill Text           ${txtStreet}            ${street}
    Fill Text           ${txtCity}              ${city}
    Fill Text           ${txtState}             ${state}
    Fill Text           ${txtCountry}           ${countryCode}
    Fill Text           ${txtpostalCode}        ${postalCode}
    Click               ${btnProceedToCheckout_3}
    Run Keyword And Continue On Failure         Wait For Elements State     ${lblBPayment}     visible