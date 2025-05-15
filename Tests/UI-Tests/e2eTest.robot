*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../../Resources/Pages/loginPage.robot
Resource            ../../Resources/Pages/homePage.robot
Resource            ../../Resources/Pages/productDetailsPage.robot
Resource            ../../Resources/Pages/checkoutPage.robot
Resource            ../../Resources/Pages/commonUI.robot

Test Setup      Setup Browser And Login
#robot -d Results Tests/UI-Tests/e2eTest.robot
Library    Collections

*** Variables ***
@{selectedProductsPrices}    # Initializes an empty list

*** Test Cases ***
Check out flow verification
    [Tags]              Smoke
    homePage.click Home
    homePage.Search product     Pliers
    ${productPrice}=    homePage.Select product
    Append To List    ${selectedProductsPrices}    ${productPrice}
    productDetailsPage.Assert product price    ${selectedProductsPrices}[0]
    productDetailsPage.Add item to cart
    homePage.clickHome
    homePage.Search product     Thor Hammer
    ${productPrice}=    homePage.Select product
    Append To List    ${selectedProductsPrices}    ${productPrice}
    productDetailsPage.Assert product price    ${selectedProductsPrices}[1]
    productDetailsPage.Add item to cart
    productDetailsPage.Load cart
    checkoutPage.Assert total price    ${selectedProductsPrices}
    checkoutPage.Click proceed to checkout step 1
    checkoutPage.Click proceed to checkout step 2
    checkoutPage.Fill billing address
    ${paymentDetailsParams}=                         Create Payment Details         buy-now-pay-later
    checkoutPage.Fill payment details   buy-now-pay-later       ${paymentDetailsParams}
    checkoutPage.Confirm payment
    checkoutPage.Get invoice number

*** Keywords ***
Setup Browser And Login
    commonUI.Open the browser
    loginPage.Click Sign In
    loginPage.Valid login   customer2@practicesoftwaretesting.com    welcome01    user

Create Payment Details
    [Arguments]    ${paymentType}
    IF    "${paymentType}" == "buy-now-pay-later"
        ${details}=    Create Dictionary    monthly_installments=3
    ELSE IF    "${paymentType}" == "credit-card"
        ${details}=    Create Dictionary    credit_card_number=0000-0000-0000-0000    expiration_date=12/2028    cvv=123    card_holder_name=jack howe
    END
    RETURN    ${details}



