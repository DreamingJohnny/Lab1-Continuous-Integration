*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ${keywords_path}/login_and_registration_keywords.robot
Resource    ${keywords_path}/cart_keywords.robot
Resource    ${keywords_path}/ticket_and_safari_keywords.robot

Variables    ${util_path}/variables.py

*** Variables ***
${html_path}    file://${EXECDIR}/website/jurap.html_path"
${keywords_path}    ${EXECDIR}/resources/keyword_files
${resource_path}    ${EXECDIR}/resources
${util_path}    ${EXECDIR}/resources/util


*** Keywords ***

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 

The User Kim Buys Tickets For Their Family
    [Tags]    safari
	Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    1
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    1
    Buy Entrance Tickets    ${child_ticket_type}    ${vip_ticket}    2    

The User Kim Books Weekend Safaris For Their Family
    [Tags]    safari
    [Arguments]    ${safari_date}    
	Book Safari    ${safari_type_herbivor_tour_feeding}    ${safari_date}
	Book Safari    ${safari_type_t_rex_rumble_thrill}    ${safari_date}

The Date Of The Safari Bookings Are Correct
    [Tags]    refactor-me
    [Arguments]    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_keyword_1}
	...    ${safari_keyword_2}    ${expected_safari_date}

    Check Cart Items Order Info    ${safari_keyword_1}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}
	Check Cart Items Order Info    ${safari_keyword_2}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}

User Booking Goes Through
    [Arguments]    ${add_to_cart_message_successful}
    ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

User Buys Every Combination Of Ticket
    [Arguments]
    Buy Entrance Tickets    ${senior_ticket_type}    ${vip_ticket}    5 
    Buy Entrance Tickets    ${senior_ticket_type}    ${regular_ticket}    4  
    Buy Entrance Tickets    ${adult_ticket_type}    ${vip_ticket}    3
    Buy Entrance Tickets    ${adult_ticket_type}    ${regular_ticket}    2
    Buy Entrance Tickets    ${child_ticket_type}    ${vip_ticket}    1
    Buy Entrance Tickets    ${child_ticket_type}    ${regular_ticket}    4

 User Books A Safari
    [Tags]    safari
    [Arguments]    ${safari_type}        ${safari_date} 
    Book safari    ${safari_type}    ${safari_date}

User Book Every Typ Of Safari
    [Tags]    safari    refactor-me
    [Arguments]   
    Book safari    ${safari_type_t_rex_rumble}    ${date_for_booking}
    Book safari    ${safari_type_herbivor_tour}    ${date_for_booking}
    Book safari    ${safari_type_t_rex_rumble_thrill}    ${date_for_booking}
    Click Element   ${cart_nav_button}
    Sleep    5
    Click Element    ${pro_to_checkout_button}
    Sleep    5