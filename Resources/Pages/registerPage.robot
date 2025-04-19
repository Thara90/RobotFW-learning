*** Settings ***
Library             Browser     timeout=0:00:20
Resource            helperBase.robot

*** Variables ***
${linkRegister}         [data-test="register-link"]
${txtFirstName}         [data-test="first-name"]
${txtLastName}          [data-test="last-name"]
${txtDOB}               [data-test="dob"]
${txtStreet}            [data-test="street"]
${txtPostalCode}        [data-test="postal_code"]
${txtState}             [data-test="state"]
${txtCity}              [data-test="city"]
${ddCountry}            [data-test="country"]
${txtPhoneNum}          [data-test="phone"]
${txtEmail}             [data-test="email"]
${txtPassword}          [data-test="password"]
${btnSubmit}            [data-test="register-submit"]

*** Keywords ***

Load registration form
    Click               ${linkRegister}


Fill registration form
    # Returned data from Make random registration data
    ${firstName}    ${lastName}    ${dateOfBirth}    ${street}    ${postalCode}    ${city}    ${state}    ${countryCode}    ${phoneNum}    ${email}    ${password}=    Make random registration data

    Fill Text           ${txtFirstName}            ${firstName}
    Fill Text           ${txtLastName}             ${lastName}
    Fill Text           ${txtDOB}                  ${dateOfBirth}
    Fill Text           ${txtStreet}               ${street}
    Fill Text           ${txtPostalCode}           ${postalCode}
    Fill Text           ${txtState}                ${state}
    Fill Text           ${txtCity}                 ${city}
    Select Options By   ${ddCountry}               value                   ${countryCode}
    Fill Text           ${txtPhoneNum}             ${phoneNum}
    Fill Text           ${txtEmail}                ${email}
    Fill Text           ${txtPassword}             ${password}
    RETURN    ${email}    ${password}

Submit registration form
    Promise To          Wait For Response                   matcher=**/users/register
    Click               ${btnSubmit}
    Wait For All Promises
