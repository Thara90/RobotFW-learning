*** Settings ***
Library             Browser     timeout=0:00:10

*** Variables ***
${browser}      chromium
${url}          https://practicesoftwaretesting.com/auth/login

*** Keywords ***

Open the browser
    Log                         Starting the test case
    New Browser                 ${browser}    headless=${False}
    New Page                    ${url}