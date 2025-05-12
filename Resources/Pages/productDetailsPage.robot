*** Settings ***
Library             Browser     timeout=0:00:20
Library    String

*** Variables ***
${btnAddToCart}                 [data-test="add-to-cart"]
${addToCartMessage}             //div[@aria-label="Product added to shopping cart."]
${lblPrice}                     [data-test="unit-price"]
${btnCart}                      [data-test="nav-cart"]
${btnProceedToCheckout}         [data-test="proceed-1"]

*** Keywords ***

Assert product price
    [Arguments]    ${price}
    ${priceValue}=    Replace String Using Regexp                           ${price}                \\$              ${EMPTY}
    Run Keyword And Continue On Failure         Get Text                    ${lblPrice}             should be       ${priceValue}

Add item to cart
    Click                                       ${btnAddToCart}
    Run Keyword And Continue On Failure         Wait For Elements State     ${addToCartMessage}     visible

Load cart
    Click                                       ${btnCart}
    Run Keyword And Continue On Failure         Wait For Elements State     ${btnProceedToCheckout} visible


