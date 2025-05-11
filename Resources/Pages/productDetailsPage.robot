*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${btnAddToCart}                 [data-test="add-to-cart"]
${addToCartMessage}             //div[@aria-label="Product added to shopping cart."]
${lblPrice}                     [data-test="unit-price"]

*** Keywords ***

Assert product price
    [Arguments]    ${price}
    Run Keyword And Continue On Failure         Get Text                    ${lblPrice}             should be       ${price}

Add item to cart
    Click                                       ${btnAddToCart}
    Run Keyword And Continue On Failure         Wait For Elements State     ${addToCartMessage}     visible

