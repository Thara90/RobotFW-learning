*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${linkHome}                     [data-test="nav-home"]
${locatorProductCard}           xpath=//a[@class='card']
${txtSearch}                    [data-test="search-query"]
${btnSearch}                    [data-test="search-submit"]
${lblProductName}               [data-test="product-name"]


*** Keywords ***

Click Home
    Click                                   ${linkHome}
    #Run Keyword And Continue On Failure     Wait For Elements State     ${locatorProductCard}    visible

Search product
    [Arguments]    ${productName}
    Fill Text                               ${txtSearch}                ${productName}
    Click                                   ${btnSearch}
    ${productCount}                         Get Element Count           ${locatorProductCard}
    Should Be Equal As Integers             ${productCount}             0

Assert valid search result
    [Arguments]    ${productName}
    Get Text                                ${lblProductName}           should be                   ${productName}

Select product
    Click                                   ${lblProductName}
    ${url}=    Get Url
    Run Keyword And Continue On Failure     Should Match Regexp         ${url}                      .*/product/[A-Z0-9]+$
