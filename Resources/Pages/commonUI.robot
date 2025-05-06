*** Settings ***
Library             Browser     timeout=0:00:10
Resource            ../../env.robot

*** Variables ***
${browser}      chromium
${url}          ${UI_URL}

*** Keywords ***

Open the browser
    Log                         Starting the test case
    New Browser                 ${browser}    headless=${False}
    New Page                    ${url}