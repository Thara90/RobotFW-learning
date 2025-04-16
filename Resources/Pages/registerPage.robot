*** Settings ***
Library             Browser     timeout=0:00:10

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
    Fill Text           ${txtFirstName}            Thara
    Fill Text           ${txtLastName}             Perera
    Fill Text           ${txtDOB}                   1990-12-09
    Fill Text           ${txtStreet}                Victoria
    Fill Text           ${txtPostalCode}           100200
    Fill Text           ${txtState}                 Western
    Fill Text           ${txtCity}                  London
    Select Options By   ${ddCountry}               value                       GB
    Fill Text           ${txtPhoneNum}                 0771189740
    Fill Text           ${txtEmail}                 testRW@mailinator.com
    Fill Text           ${txtPassword}              Nexus@19901209

Submit registration form
    Promise To          Wait For Response                   matcher=**/users/register
    Click               ${btnSubmit}
    Wait For All Promises
