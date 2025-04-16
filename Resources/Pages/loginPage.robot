*** Settings ***
Library             Browser     timeout=0:00:10

*** Variables ***
${btnSignIn}        [data-test="nav-sign-in"]
${txtEmail}         [data-test="email"]
${txtPassword}      [data-test="password"]
${btnLogin}         [data-test="login-submit"]

*** Keywords ***

Click Sign In
    Click                   ${btnSignIn}

Login to system
    Fill Text               ${txtEmail}                 customer@practicesoftwaretesting.com
    Fill Text               ${txtPassword}              welcome01
    Click                   ${btnLogin}
    Wait For Condition      Url                                 should end with    /account
