*** Settings ***
Library             Browser     timeout=0:00:20
Library    String

*** Variables ***
${locatorItemPrice}           [data-test="line-price"]


*** Keywords ***

Assert total price
    ${productCount}                         Get Element Count           ${locatorItemPrice}