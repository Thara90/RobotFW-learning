*** Settings ***
Documentation       This is basic info about whole test suite
Resource            ../Resources/Pages/loginPage.robot
Resource            ../Resources/Pages/homePage.robot
Resource            ../Resources/Pages/productDetailsPage.robot
Resource            ../Resources/Pages/common.robot

Test Setup      Setup Browser And Login
 #robot -d Results Tests/e2eTest.robot

*** Test Cases ***
Check out flow verification
    [Documentation]     This is some basic infor about test
    [Tags]              Smoke
    homePage.clickHome
    homePage.Search product    Thor Hammer
    homePage.Assert valid search result    Thor Hammer
    homePage.Select product
    productDetailsPage.Add item to cart

*** Keywords ***
Setup Browser And Login
    common.Open the browser
    loginPage.Valid login   customer2@practicesoftwaretesting.com    welcome01    user

