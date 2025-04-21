*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${linkHome}                     [data-test="nav-home"]
${locatorProductCard}           xpath=//a[@class='card'][1]
${txtSearch}                    [data-test="search-query"]
${btnSearch}                    [data-test="search-submit"]
${lblProductName}               [data-test="product-name"]


*** Keywords ***

Click Home
    Click                       ${linkHome}
    Wait For Elements State     ${locatorProductCard}    visible

Search product
    [Arguments]    ${productName}
    Fill Text                   ${txtSearch}             ${productName}
    Click                       ${btnSearch}

Assert valid search result
    [Arguments]    ${productName}
    Get Text                     ${lblProductName}       should be          ${productName}

Select product
    Click                        ${lblProductName}
    ${url}=    Get Url
    Should Match Regexp    ${url}    .*/product/[A-Z0-9]+$
