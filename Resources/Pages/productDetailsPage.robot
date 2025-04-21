*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${btnAddToCart}                 [data-test="add-to-cart"]
${addToCartMessage}             //div[@aria-label="Product added to shopping cart."]

*** Keywords ***

Add item to cart
    Click                       ${btnAddToCart}
    Wait For Elements State     ${addToCartMessage}    visible
