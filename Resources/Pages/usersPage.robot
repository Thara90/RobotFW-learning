*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${ddNavigationMenu}     [data-test="nav-menu"]
${usersLink}            [data-test="nav-admin-users"]

*** Keywords ***

Load users
    Click                   ${ddNavigationMenu}
    Click                   ${usersLink}
    Wait For Condition      Url                         should end with    /admin/users

Delete users
    [Arguments]    ${email}
    Click                       xpath=//td[normalize-space(text())="${email}"]/following-sibling::td//button
    Wait For Elements State     xpath=//td[normalize-space(text())="${email}"]/following-sibling::td//button    hidden
    Log  ${email} user is deleted


