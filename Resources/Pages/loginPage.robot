*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${btnSignIn}                [data-test="nav-sign-in"]
${txtEmail}                 [data-test="email"]
${txtPassword}              [data-test="password"]
${btnLogin}                 [data-test="login-submit"]
${ddNavigationMenu}         [data-test="nav-menu"]
${btnSignout}               [data-test="nav-sign-out"]
${lblLoginErrorMessage}     [data-test="login-error"]

*** Keywords ***

Click Sign In
    Click                   ${btnSignIn}

Fill login form
    [Arguments]    ${username}    ${password}
    Fill Text               ${txtEmail}                 ${username}
    Fill Text               ${txtPassword}              ${password}
    Click                   ${btnLogin}

Valid login
    [Arguments]    ${username}    ${password}    ${role}
    Fill Login Form         ${username}    ${password}
    IF  $role=="admin"
        ${expectedUrl}=         Set Variable    /admin/dashboard
    ELSE IF  $role == "user"
        ${expectedUrl}=         Set Variable    /account
    ELSE
       Log  fail
    END
    Wait For Condition      Url    should end with    ${expectedUrl}

Invalid login
    [Arguments]                             ${username}    ${password}    ${role}
    Fill Login Form                         ${username}    ${password}
    Run Keyword And Continue On Failure     Wait For Elements State         ${lblLoginErrorMessage}         visible
    Run Keyword And Continue On Failure     Get Text                        ${lblLoginErrorMessage}         should be   Invalid email or password

Logout
        Click                   ${ddNavigationMenu}
        Click                   ${btnSignout}
