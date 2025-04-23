*** Settings ***
Library                  RequestsLibrary
Library                  Collections

*** Variables ***
${BASE_URL}              https://api.practicesoftwaretesting.com

*** Keywords ***
Create API Session
    Create Session    mainSession    ${BASE_URL}   verify=True
