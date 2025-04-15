*** Settings ***
Library             Browser     timeout=0:00:10

*** Variables ***

*** Keywords ***

Click Sign In
    Click                   [data-test="nav-sign-in"]

Login to system
    Fill Text               [data-test="email"]                 customer@practicesoftwaretesting.com
    Fill Text               [data-test="password"]              welcome01
    Click                   [data-test="login-submit"]
    Wait For Condition      Url                                 should end with    /account
