*** Settings ***
Library             Browser     timeout=0:00:20
Library    OperatingSystem

*** Variables ***
${linkHome}                     [data-test="nav-home"]
${locatorProductCard}           xpath=//a[@class='card']
${txtSearch}                    [data-test="search-query"]
${btnSearch}                    [data-test="search-submit"]
${lblProductName}               xpath=(//h5[@data-test='product-name'])
${lblOutOfStock}                [data-test="out-of-stock"]


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
    IF    ${productCount} >= 0
    FOR    ${i}    IN RANGE    1    ${productCount + 1}
           ${name}                          Get Text                    xpath=(//h5[@data-test='product-name'])[${i}]
           Run Keyword And Continue On Failure                          Should Contain                                      ${name}    ${productName}
    END
    ELSE
           Fail    No products found matching: ${productName}
    END

Select product
    ${productCount}                         Get Element Count           ${locatorProductCard}
    FOR    ${i}    IN RANGE    1    ${productCount + 1}
           ${footerValue}                   Get Text                    xpath=(//h5[@data-test='product-name'])[${i}]/parent::div/following-sibling::div/span[1]
           IF   $footerValue != "Out of stock"
                Click                       xpath=(//h5[@data-test='product-name'])[${i}]
                ${url}=    Get Url
                Run Keyword And Continue On Failure     Should Match Regexp         ${url}                      .*/product/[A-Z0-9]+$
                RETURN      ${footerValue}
                BREAK
           ELSE
                ${productName}              Get Text                    xpath=(//h5[@data-test='product-name'])[${i}]
                Log                         Out of Stock: ${productName}
           END
           Fail    All products are out of stock
    END


