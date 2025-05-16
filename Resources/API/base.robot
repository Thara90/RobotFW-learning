*** Settings ***
Library         RequestsLibrary
Library         JSONLibrary
Library         OperatingSystem
Library         Collections
Resource        ../../env.robot

*** Variables ***
${BASE_URL}              ${API_URL}

*** Keywords ***
Create API Session
    Create Session    mainSession    ${BASE_URL}   verify=True
