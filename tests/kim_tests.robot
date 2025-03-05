*** Settings ***
Library    SeleniumLibrary
Library    OperatingSystem

Resource    ../resources/keyword_files/keywords.robot

Variables    ../resources/util/variables.py
Variables    ../resources/util/kim_specific_variables.py

Test Setup    Setup Suite Open Page And Register User    ${kim_username}    ${kim_password}
Test Teardown    Teardown Suite

*** Test Cases ***
Valid browser login
    [Tags]    Johan-Ahlsten    refactor-me
    Click Specific Button    ${login_button}
	Input Credentials    ${kim_username}    ${login_username_text_box}    ${kim_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}
	Sleep    3

User sees the correct price total on tickets in cart
    [Tags]    Johan-Ahlsten    refactor-me
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Kim Buys Tickets For Their Family
    Then The The Total Price Is Correct    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}

User purchase tickets for their family
    [Tags]    Johan-Ahlsten    refactor-me
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
    When The User Kim Buys Tickets For Their Family
	And The User Purchases The Tickets    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Then The Price In The Popup Is Correct    ${kim_expected_ticket_cost_total}

User books weekend safaris for their family
    [Tags]    Johan-Ahlsten    refactor-me
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
	And The User Kim Buys Tickets For Their Family
    When The User Kim Books Weekend Safaris For Their Family    ${kim_safari_date}
    Then The Date Of The Safari Bookings Are Correct    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_type_herbivor_tour_feeding}
	...    ${safari_type_t_rex_rumble_thrill}    ${kim_expected_safari_date}

User purchases weekend safaris for their family
    [Tags]    Johan-Ahlsten    refactor-me
    Given The User Is Logged In To Their Account    ${login_button}    ${kim_username}    ${kim_password}    
	...    ${login_username_text_box}    ${login_password_text_box}    ${login_submit_button}
	And The User Kim Buys Tickets For Their Family
    When The User Kim Books Weekend Safaris For Their Family	${kim_safari_date}
    And The User Purchases The Safaris    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Then The Price In The Popup Is Correct    ${kim_expected_vacation_cost_total}