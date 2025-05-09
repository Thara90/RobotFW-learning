*** Settings ***
Library             Browser     timeout=0:00:20

*** Variables ***
${linkHome}                     [data-test="nav-home"]
${locatorProductCard}           xpath=//a[@class='card']
${txtSearch}                    [data-test="search-query"]
${btnSearch}                    [data-test="search-submit"]
${lblProductName}               xpath=(//h5[@data-test='product-name'])


*** Keywords ***

Click Home
    Click                                   ${linkHome}
    #Run Keyword And Continue On Failure     Wait For Elements State     ${locatorProductCard}    visible

Search product
    [Arguments]    ${productName}
    Fill Text                               ${txtSearch}                ${productName}
    Promise To                              Wait For Response           matcher=**/products/search?q=*
    Click                                   ${btnSearch}
    Wait For All Promises
    ${productCount}                         Get Element Count           ${locatorProductCard}
    Should Be True                          ${productCount} > 0
    FOR    ${i}    IN RANGE    1    ${productCount + 1}

           ${name}                          Get Text                    xpath=(//h5[@data-test='product-name'])[${i}]
           Run Keyword And Continue On Failure                          Should Contain                                      ${name}    ${productName}
    END

Select product
    Click                                   ${lblProductName}
    ${url}=    Get Url
    Run Keyword And Continue On Failure     Should Match Regexp         ${url}                      .*/product/[A-Z0-9]+$

Get product price

