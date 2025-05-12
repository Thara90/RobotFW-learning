*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../../Resources/Pages/loginPage.robot
Resource            ../../Resources/Pages/homePage.robot
Resource            ../../Resources/Pages/productDetailsPage.robot
Resource            ../../Resources/Pages/commonUI.robot

Test Setup      Setup Browser And Login
 #robot -d Results Tests/UI-Tests/e2eTest.robot

*** Test Cases ***
Check out flow verification
    [Tags]              Smoke
    homePage.clickHome
    homePage.Search product     Pliers
    ${footerValue}=    homePage.Select product
    productDetailsPage.Assert product price    ${footerValue}
    productDetailsPage.Add item to cart


*** Keywords ***
Setup Browser And Login
    commonUI.Open the browser
    loginPage.Click Sign In
    loginPage.Valid login   customer2@practicesoftwaretesting.com    welcome01    user



