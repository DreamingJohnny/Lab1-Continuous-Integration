*** Settings ***
Library    SeleniumLibrary

Resource    ../resources/keyword_files/keywords.robot
Resource    ../resources/keyword_files/from_original_keywords.robot
Variables    ../resources/util/variables.py

Documentation   Grupp 2 Wille, Johan och Kristin. Generic test suite for general test functions as a base library.

#Test setup that starts up the page in a browser and registers a user. (by Wille)
Test Setup    Setup Suite Open Page And Register User    ${valid_username}    ${valid_password}
Test Teardown    Teardown Suite 

*** Test Cases ***
#Invalid login test to see if the page need correct credentials.
Invalid browser login
    [Tags]    Wille-Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${invalid_username}    ${login_username_text_box}    ${invalid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
#Valid login test to see that login works with valid credentials.
    Message Should Be Visible    ${error_message_element_demo}    ${error_message_demo}    ${standard_timeout}    ${verifying_message}
Valid browser login
    [Tags]    Wille-Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element    ${login_submit_button}   
    Sleep    3
#Logout test to see that the logout feature of the page works.
Valid browser logout
    [Tags]    Wille-Virtanen
    Click Specific Button    ${login_button}
    Input Credentials    ${valid_username}    ${login_username_text_box}    ${valid_password}    ${login_password_text_box}
    Click Element   ${login_submit_button}
    Sleep    3
    Logout    ${logout_button}
#Test for booking an buying a regular adult ticket.
Booking 1 regular adult ticket
    [Tags]    Wille-Virtanen Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    1

Booking 2 regular adult ticket
    [Tags]    Wille Virtanen Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    2

#Test for booking and buying Safari.
Booking Safari
    [Tags]    Wille-Virtanen Johan-Ahlsten
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    1
    Book Safari    ${safari_type_herbivor_tour}    ${date_for_booking}

#Test for removing items from cart.
Removing object from cart
    [Tags]    Wille-Virtanen    refactor-me
    Log In User    ${valid_username}    ${valid_password}
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    1
    Book Safari    ${safari_type_t_rex_rumble}    ${date_for_booking}
    User Navigates To Cart Section
    Click Element    ${second_object_in_cart}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5
    Handle Alert    action=DISMISS
    Sleep    5

User Can Not Register Username That Already Exists
    [Documentation]    This test verifies that an error message is displayed if user tries to register an already registered username.
    [Tags]    Kristin    pipeline-testing
    Given User Is Registered    ${valid_username}    ${valid_password}
    When User Registers Username    ${valid_username}    ${valid_password}
    Then User Should Get Message That Username Already Exists    

User That Is Not Logged In Can Not Add Ticket To Cart
    [Documentation]    This test verifies that an error alert is displayed if user that is not logged in tries to buy entrance ticket. 
    [Tags]    Kristin    pipeline-testing    
    Given No one is logged in
    When User Buys Ticket
    Then User Should Recieve Alert    ${ticket_login_error_message}

User That Is Not Logged In Can Not Book Safari
    [Documentation]    This test verifies that an error alert is displayed if user that is not logged in tries to book a safari. 
    [Tags]    Kristin
    Given No one is logged in
    When User Books Safari
    Then User Should Recieve Alert    ${safari_login_error_message}

User With Regular Ticket Can Not Book VIP Safari
    [Documentation]    This test verifies that an error message is displayed if user tries to book VIP safari without VIP ticket.
    [Tags]    Kristin
    Given User Is Logged In    ${valid_username}    ${valid_password}
    And Regular Entrance Ticket is Added To Cart
    When User books VIP safari
    Then User Should Get Message That Only VIP User Can Book VIP Safaris
    
User With Regular Ticket Can Not Book Safari On Weekend
    [Documentation]    This test verifies that an error message is displayed if user tries to book safari on a weekend without VIP ticket.
    [Tags]    Kristin
    Given User Is Logged In    ${valid_username}    ${valid_password}
    And Regular Entrance Ticket Is Added To Cart
    When User Books Safari On A Weekend
    Then User Should Get Message That VIP Ticket Is Required