*** Settings ***
Library             Browser     timeout=0:00:20
Library    String

*** Variables ***
${btnAddToCart}                 [data-test="add-to-cart"]
${addToCartMessage}             //div[@aria-label="Product added to shopping cart."]
${lblPrice}                     [data-test="unit-price"]
${btnCart}                      [data-test="nav-cart"]
${breadCrumb}                   xpath=//ul[@class='steps-4 steps-indicator']

*** Keywords ***

Assert product price
    [Arguments]    ${expectedPrice}
    #${priceValue}=    Replace String Using Regexp                           ${price}                \\$              ${EMPTY}
    ${price_text}=    Get Text    ${lblPrice}
    ${actualPrice}=  Convert To Number    ${price_text}
    Run Keyword And Continue On Failure    Should Be Equal As Numbers    ${actualPrice}    ${expectedPrice}

Add item to cart
    Click                                       ${btnAddToCart}
    Run Keyword And Continue On Failure         Wait For Elements State     ${addToCartMessage}     visible

Load cart
    Click                                       ${btnCart}
    Run Keyword And Continue On Failure         Wait For Elements State     ${breadCrumb}           visible


