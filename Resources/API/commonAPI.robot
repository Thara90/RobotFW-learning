*** Settings ***
Library                  RequestsLibrary
Library                  Collections
Resource                 ../../env.robot

*** Variables ***
${BASE_URL}              ${API_URL}

*** Keywords ***
Create API Session
    Create Session    mainSession    ${BASE_URL}   verify=True
