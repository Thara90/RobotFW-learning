*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../../Resources/Pages/loginPage.robot
Resource            ../../Resources/Pages/homePage.robot
Resource            ../../Resources/Pages/productDetailsPage.robot
Resource            ../../Resources/Pages/commonUI.robot

Test Setup      Setup Browser And Login
 #robot -d Results Tests/UI-Tests/e2eTest.robot
Library    Collections

*** Variables ***
@{selected_products}    # Initializes an empty list

*** Test Cases ***
Check out flow verification
    [Tags]              Smoke
    homePage.clickHome
    homePage.Search product     Pliers
    ${productPrice}=    homePage.Select product
    Append To List    ${selected_products}    ${productPrice}
    productDetailsPage.Assert product price    ${selected_products}[0]
    productDetailsPage.Add item to cart
    homePage.clickHome
    homePage.Search product     Thor Hammer
    ${productPrice}=    homePage.Select product
    Append To List    ${selected_products}    ${productPrice}
    productDetailsPage.Add item to cart
    Log     ${selected_products}
    productDetailsPage.Load cart


*** Keywords ***
Setup Browser And Login
    commonUI.Open the browser
    loginPage.Click Sign In
    loginPage.Valid login   customer2@practicesoftwaretesting.com    welcome01    user



