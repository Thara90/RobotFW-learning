*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${btnSignIn}            [data-test="nav-sign-in"]
${txtEmail}             [data-test="email"]
${txtPassword}          [data-test="password"]
${btnLogin}             [data-test="login-submit"]
${ddNavigationMenu}     [data-test="nav-menu"]
${btnSignout}           [data-test="nav-sign-out"]

*** Keywords ***

Click Sign In
    Click                   ${btnSignIn}

Login to system
    [Arguments]    ${username}    ${password}    ${role}
    Fill Text               ${txtEmail}                 ${username}
    Fill Text               ${txtPassword}              ${password}
    Click                   ${btnLogin}
    IF  $role=="admin"
        ${expectedUrl}=         Set Variable    /admin/dashboard
    ELSE IF  $role == "user"
        ${expectedUrl}=         Set Variable    /account
    ELSE
       Log  fail
    END
    Wait For Condition      Url    should end with    ${expectedUrl}

Logout
        Click                   ${ddNavigationMenu}
        Click                   ${btnSignout}
