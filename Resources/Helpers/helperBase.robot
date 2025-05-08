*** Settings ***
Library         FakerLibrary    locale=en_US

*** Keywords ***

Make random registration data
    ${firstName}=           FakerLibrary.First Name
    ${lastName}=            FakerLibrary.Last Name
    ${firstName}=           Set Variable                Automation${firstName}
    ${lastName}=            Set Variable                Automation${lastName}
    ${dateOfBirth}=         Set Variable                1990-12-09
    ${street}=              FakerLibrary.Street Name
    ${postalCode}=          FakerLibrary.Random Number  digits=4  fix_len=True
    ${postalCode}=          Convert To String           ${postalCode}
    ${city}=                FakerLibrary.City
    ${state}=               FakerLibrary.State
    ${countryCode}=         FakerLibrary.Country Code
    ${phoneNum}=            FakerLibrary.Random Number  digits=10  fix_len=True
    ${phoneNum}=            Convert To String           ${phoneNum}
    ${email}=               Set Variable                ${firstName}@mailinator.com
    ${password}=            Set Variable                Nexus@19901209
    RETURN    ${firstName}    ${lastName}    ${dateOfBirth}    ${street}    ${postalCode}    ${city}    ${state}    ${countryCode}    ${phoneNum}    ${email}    ${password}