*** Settings ***
Library    SeleniumLibrary
Library    .venv/Lib/site-packages/robot/libraries/Collections.py

*** Keywords ***
Open Browser To Page
    [Arguments]    ${url}    ${browser}    ${title}
    Open Browser    ${url}    ${browser}
    Title Should Be    ${title}
Click Specific Button
    [Arguments]    ${button}
    Click Element    ${button}
Input Credentials
    [Arguments]    ${username}    ${username_space}    ${password}    ${password_space}
    Input Text    ${username_space}    ${username}
    Input Text    ${password_space}    ${password}
Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}    ${timeout}    ${good_mess}
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${good_mess}
    Sleep    5s
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${error_message_text}
Registration
    [Arguments]    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Click Specific Button    ${regin_button}
    Input Credentials    ${username}    ${username_text_box}    ${password}    ${password_text_box}
    Click Element    ${reg_sub_button}
Logout
    [Arguments]    ${button}
    Click Specific Button    ${button}
    Sleep    3
    Handle Alert    action=DISMISS
    Sleep    3

Increase value
    [Arguments]    ${input_id}    ${direction}
    Press Keys  ${input_id}  ${direction} 
Buy A Ticket
    [Arguments]    ${cat}    ${type}    ${type_field}    ${cat_field}    ${input_counter}    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}
    Click Specific Button    ${buy_ticket_button}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    Sleep    5
    Click Button    ${add_to_cart_button}
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Buy More Than One Ticket
    [Arguments]    ${cat}    ${type}    ${amount}    ${type_field}    ${cat_field}    ${input_counter}    ${button_one}    ${button_two}    ${add_to_cart_message_successful}
    Click Specific Button    ${button_one}
    Sleep    5
    Select From List By Value    ${type_field}    ${type} 
    Select From List By Value    ${cat_field}    ${cat}
    WHILE    True    limit=${amount}    on_limit=pass    
    Increase value    ${input_counter}    ARROW_UP
    END 
    Sleep    5
    Click Button    ${button_two}
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Book Safari
    [Arguments]    ${saf_button}    ${saf_date_field}    ${date}    ${saf_type_field}    ${saf_type}    ${saf_sub_button}    ${add_to_cart_message_succesful}
    Click Element    ${saf_button}
    Sleep    5
    #When booking remember to always put six numer in the year slot and start with two 00 as Max has failed in his programing ;)
    Input Text    ${saf_date_field}    ${date}
    Sleep    5    
    Select From List By Value    ${saf_type_field}    ${saf_type}
    Sleep    5
    Click Element    ${saf_sub_button}
    Sleep    5
     ${alert_text}    Handle Alert    action=DISMISS
	Should Contain    ${alert_text}    ${add_to_cart_message_successful}

Check Shopping Cart Total
    [Arguments]    ${expected_total}    ${cart_tab}    ${cart_total_xpath}
    Click Specific Button    ${cart_tab}
	${actual_text}    Get Text    ${cart_total_xpath}
	Should Contain    ${actual_text}    ${expected_total}



#I think this might be the old function...?
Check Cart Items Order Info
    [Arguments]    ${item_to_check}    ${expected_text}    ${cart_tab}    ${cart_list_xpath}
	
	# The function checks all items that are list items in the cart list.
	# It then takes those that has the text in item_to-check
	# And makes sure all of those also contains the expected text.
	Click Specific Button    ${cart_tab}

    ${elements}    Get WebElements    ${cart_list_xpath}
    
    ${filtered_items}    Create List
    FOR    ${el}    IN    @{elements}
        ${text}    Get Text    ${el}
		# If statement appends the text of the element to list, if element-text contains the text we are checking for 
        IF    $item_to_check in $text
            Append To List    ${filtered_items}    ${text}
        END
    END

    Should Not Be Empty    ${filtered_items}    No items found with ${item_to_check}!

    FOR    ${item}    IN    @{filtered_items}
        Should Contain    ${item}    ${expected_text}
    END

The User Is Logged In To Their Account
    [Arguments]    ${login_tab}    ${username}    ${password}    ${username_field}    ${password_field}    ${submit_login_button}
	Click Specific Button    ${login_tab}
	Input Credentials    ${username}    ${username_field}    ${password}    ${password_field}
	Click Specific Button    ${submit_login_button}
	Sleep    3

	# TODO: Need to add way to check that they logged in correctly here.

The User Buys Tickets For Their Family
    [Arguments]        ${buy_ticket_button}    ${regular_ticket}    ${vip_ticket}
	...    ${adult_ticket_type}    ${child_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${add_to_cart_button}
	...    ${add_to_cart_message_successful}
	
	Buy A Ticket    ${regular_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}    ${add_to_cart_message_successful}
    
	Buy A Ticket    ${vip_ticket}    ${adult_ticket_type}    ${ticket_type_field}
	...    ${ticket_cat_field}    ${input_of_ticket_counter}    ${buy_ticket_button}    
	...    ${add_to_cart_button}    ${add_to_cart_message_successful}
    
	# TODO: Look into how to have the number one here be sent through in some way, instead of appearing here.
	Buy More Than One Ticket    ${vip_ticket}    ${child_ticket_type}    1
	...    ${ticket_type_field}    ${ticket_cat_field}    ${input_of_ticket_counter}
	...    ${buy_ticket_button}    ${add_to_cart_button}    ${add_to_cart_message_successful}

The User Proceeds To The Cart    
    [Arguments]    ${cart_nav_button}
    # TODO: Look @ this with help, should this keyword be here? If it just wraps another?
    # If yes, why not take in variables of the page straight to this script?
	Click Specific Button    ${cart_nav_button}

Check Item Info Is Correct
    [Arguments]    ${list_xpath}    ${item_text_to_check}    ${text_to_search_for}
	
	# The function checks all items that are list items in the cart list.
	# It then takes those that has the text in item_to-check
	# And makes sure all of those also contains the expected text.

    ${elements}    Get WebElements    ${list_xpath}
    
    ${filtered_items}    Create List
    FOR    ${el}    IN    @{elements}
        ${text}    Get Text    ${el}
		# If statement appends the text of the element to list, if element-text contains the text we are checking for 
        IF    $item_text_to_check in $text
            Append To List    ${filtered_items}    ${text}
        END
    END

    # Think about maybe removing this one, if we want to see if the item has the correct values instead?
    Should Not Be Empty    ${filtered_items}    No items found with ${item_text_to_check}!

    FOR    ${item}    IN    @{filtered_items}
	        # Checks if item starts with a digit, if true, copies that number to result-variable
            ${result}    Evaluate    re.match(r'^(\d+)', ${item})    modules=re
            Run Keyword If    ${result}
    ...        Check If Text Contains Correct Multiplied Value    ${item}    ${text_to_search_for}    ${result.group(1)}
    ...    ELSE 
    ...        Check If Text Contains Expected Text    ${item}    ${text_to_search_for}
	END

Check If Text Contains Correct Multiplied Value
    [Arguments]    ${cart_order}    ${expected_cost}    ${amount_of_order}

    #Converts expected_cost to integer
    ${expected_cost_int}    Convert To Integer    ${expected_cost}
    ${multiplied_value}    Evaluate    ${expected_cost_int} * int(${amount_of_order})

    #Checks if the text contains the correct multiple of the value
    ${contains_value}    Evaluate    str(${multiplied_value}) in ${cart_order}
    Run Keyword If    ${contains_value}    Log    '${cart_order}' contains '${multiplied_value}'!
    ...    ELSE    Log    '${cart_order}' does NOT contain '${multiplied_value}'!

Check If Text Contains Expected Text
    [Arguments]    ${cart_order}    ${expected_cost}

    ${contains_cost}    Evaluate    str(${expected_cost}) in ${cart_order}
    Run Keyword If    ${contains_cost}    Log    '${cart_order}' contains '${expected_cost}'!
    ...    ELSE    Log    '${cart_order}' does NOT contain '${expected_cost}'!       


# So, I think this one is also old and can be removed
The Cart Shows The Correct Prices On The Items
    [Arguments]    ${cart_list_xpath}    ${cart_tab_xpath}    ${ITEM_PRICES}
	Click Specific Button    ${cart_tab_xpath}
	# So, for each item in item prices, check if it is in the cart, and if it is, check so that the price is right
	# So, here I'll want to set up a keyword called, info in items is correct, basically, and then have that one go through all of the items and check them.
	
    FOR    ${pair}    IN    @{ITEM_PRICES}
        ${first}    ${second} =    Set Variable    ${pair}[0]    ${pair}[1]
        Check Item Info Is Correct    ${cart_list_xpath}    ${first}    ${second}
    END

The The Total Price Is Correct
    [Arguments]    ${cart_tab_xpath}    ${kim_expected_ticket_cost_total}    ${cart_total_xpath}
	Check Shopping Cart Total    ${kim_expected_ticket_cost_total}    ${cart_tab_xpath}    ${cart_total_xpath}

The User Purchases The Tickets
    [Arguments]    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}
	# So, if we don't handle the popup here, but instead does that in the next step? We need to check so that works.

The User Purchases The Safaris
    [Arguments]    ${cart_tab_xpath}    ${proceed_to_checkout_button}
	Click Specific Button    ${cart_tab_xpath}
	Click Specific Button    ${proceed_to_checkout_button}

The Price In The Popup Is Correct
    [Arguments]    ${expected_cost_total}
	${alert_text}    Handle Alert
	Should Contain    ${alert_text}    ${expected_cost_total}

The User Books Weekend Safaris For Their Family
    [Arguments]    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${safari_type_t_rex_rumble_thrill}    ${add_to_cart_message_successful}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_herbivor_tour_feeding}    ${safari_submit_button}
	...    ${add_to_cart_message_successful}
	Book Safari    ${safari_button}    ${safari_date_field}    ${kim_safari_date}
	...    ${safari_type_field}    ${safari_type_t_rex_rumble_thrill}    ${safari_submit_button}
	...    ${add_to_cart_message_successful}

The Date Of The Safari Bookings Are Correct
    [Arguments]    ${cart_list_xpath}    ${cart_tab_xpath}    ${safari_keyword_1}
	...    ${safari_keyword_2}    ${expected_safari_date}

    # So, these should change to the new function then.
    Check Cart Items Order Info    ${safari_keyword_1}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}
	Check Cart Items Order Info    ${safari_keyword_2}    ${expected_safari_date}    ${cart_tab_xpath}    ${cart_list_xpath}

#Setup and Teardown
Setup Suite
    [Arguments]    ${url}    ${browser}    ${title}    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}
    Open Browser To Page    ${url}    ${browser}    ${title} 
    Registration    ${username}    ${username_text_box}    ${password}    ${password_text_box}    ${regin_button}    ${reg_sub_button}

Teardown Suite    
    Close Browser