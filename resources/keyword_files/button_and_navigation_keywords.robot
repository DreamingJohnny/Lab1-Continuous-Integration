*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Variables    ${util_path}/variables.py

*** Variables ***
${html_path}    file://${EXECDIR}/website/jurap.html_path"
${keywords_path}    ${EXECDIR}/resources/keyword_files
${resource_path}    ${EXECDIR}/resources
${util_path}    ${EXECDIR}/resources/util


*** Keywords ***

###  Navigation ###

User Navigates To Login Section
    Press Login Button    
    Wait Until Page Contains Element    ${login_section}

User Navigates To Register Section
    Press Register Button
    Wait Until Page Contains Element    ${reg_section}
     
User Navigates To Buy Ticket Section
    Press Ticket Button
    Wait Until Page Contains Element    ${tickets_section} 

User Navigates To Safari Section
    Press Safari Button
    Wait Until Page Contains Element    ${safari_section}
 
User Navigates To Cart Section
    Press Cart Button
    Wait Until Page Contains Element    ${cart_section}

### Buttons ###

User Presses Submit Registration Button
    [Documentation]    This keyword executes pressing registration submit button.
    Press Register Submit Button

User Presses Login Submit Button
    [Documentation]    This keyword executes pressing login button.
    Press Login Submit Button

User Presses Safari "Add To Cart" Button
    Press Add Safari To Cart Button

User Presses Ticket "Add To Cart" Button
    Press Add Ticket To Cart Button
    
User Presses Proceed To Checkout
    [Documentation]    This keyword navigates to cart and presses "Proceed to checkout" button.
    User Navigates To Cart Section
    Press Proceed to checkout button

### Buttons should be visible ###

Login Button Should Be Visible
    Element Should Be Visible    ${login_button}

Logout Button Should Be Visible
    Element Should Be Visible    ${logout_button}

### Pressing buttons ###

Press Login Button
    Click Specific Button    ${login_button}
    Wait Until Page Contains Element    ${login_section}

Press Ticket Button
    Click Specific Button    ${buy_ticket_button}
    Wait Until Page Contains Element    ${tickets_section}

Press Safari Button
    Click Specific Button    ${safari_button}
    Wait Until Page Contains Element    ${safari_section}

Press Cart Button
    Click Specific Button    ${cart_nav_button}
    Wait Until Page Contains Element    ${cart_section}

Press Logout Button
    Click Specific Button    ${logout_button}
    Sleep    2

Press Register Button
    Click Specific Button    ${reg_button}
    Sleep    2

Press Login Submit Button
    Click Specific Button    ${login_submit_button}
    Sleep    2

Press Add Safari To Cart Button
    Click Specific Button    ${safari_submit_button}
    Sleep    2

Press Add Ticket To Cart Button
    Click Specific Button    ${add_to_cart_button}
    Sleep    2

Press Register Submit Button
    Click Specific Button    ${reg_submit_button}
    Sleep    2

Press Proceed To Checkout Button
    Click Specific Button    ${pro_to_checkout_button}
    Sleep    2

### Page is opened to.. ###

Page Is Opened To Login Page
    [Documentation]    This keyword executes and verifies navigation to login section. 
    User Navigates To Login Section
    Page Should Contain Element    ${login_section}

Page Is Opened To Registration Section
    [Documentation]    This keyword executes and verifies navigation to user registration section.
    Press Register Button
    Page Should Contain Element    ${reg_section}

Page Is Opened To Safari Section
    [Documentation]    This keyword executes and verifies navigation to safari booking section.
    Press Safari Button
    Page Should Contain Element    ${safari_section}

###### From original 

Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Specific Button
    [Arguments]    ${button}
    Click Element    ${button}