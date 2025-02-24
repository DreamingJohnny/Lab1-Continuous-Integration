
# Group 3: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary
Library    Collections
Library    XML

Resource    keywords.robot
Resource    VG_Kristin_user_generic_keywords.robot

Variables    variables.py
Variables    pal_specific_variables.py


*** Keywords ***

Pal Setup
    [Documentation]    This setup opens browser to JurasStina-Kalle park home page.
    Open Browser To Page    ${url_demo}    ${browser}    ${title_demo} 

Pal Teardown
    [Documentation]    This teardown closes browser.
    Close Browser



### Registration ###

User Pal Enters Registration Credentials
    [Documentation]    This keyword enters pal's registration credentials into registration fields.
    User Enters Registration Credentials    ${pal_username}    ${pal_password}
    
User Pal Should be Registered
    [Documentation]    This keyword verifies that user pal is registerd as a user,
    ...    by fetching list of users with javascript and finding pal's username in list.
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
    ...    return users.some(u => u.username === 'StinaPalle');
    Should Be True    ${userRegistered}

User Pal Is Registered
    [Documentation]    This keyword executes and verifies user pal registration.
    User Navigates To Register Section
    User Pal Enters Registration Credentials
    Press Register Submit Button
    User Pal Should be Registered


### Login ###

Log In User Pal
    User Navigates To Login Section
    User Pal Enters Login Credentials
    Press Login Submit Button

User Pal Enters Login Credentials
    [Documentation]    This keyword enters pal's login credentials into login fields.
    User Enters Login Credentials    ${pal_username}    ${pal_password}

User Pal Should Be Logged In
    [Documentation]    This keyword verifies that user pal is logged in.
    User Should Be Logged In    ${pal_username}

User Pal Is Logged In
    [Documentation]    This keyword executes and verifies user pal login.
    User Pal Is Registered
    Log In User Pal
    User Pal Should Be Logged In


### Buying entrance ticket ###


Pal Buys Entrance Ticket 
    [Documentation]    This keyword executes and verifies adding entrance ticket of pal's choice to cart.
    Buy Entrance Tickets    ${pal_ticket_type}    ${pal_ticket_category}    ${1}


### Safari bookings ###

Pal Books Safaris
    [Documentation]    This keyword executes and verifies the booking process 
    ...    of pal's selected safari types and date.
    VG_Kristin_user_generic_keywords.Book Safari    ${safari_type_t_rex_rumble}    ${pal_safari_date}
    VG_Kristin_user_generic_keywords.Book Safari    ${safari_type_herbivor_tour}    ${pal_safari_date}

### Cart ###

Pal Entrance Ticket Should be Added To Cart
    [Documentation]    This keyword verifies that pal's entrance ticket is in cart.
    ${listOfCartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${listOfCartItemDescriptioins}       1 Regular Adult Ticket(s)    1

Pal Entrance Ticket Is Added To Cart
    [Documentation]    This keyword executes and verifies adding pal's entrance ticket to cart.
    Press Ticket Button
    Pal Buys Entrance Ticket
    Pal Entrance Ticket Should be Added To Cart
    
Pal Safaris Should Be Added To Cart
    [Documentation]    This keyword verifies that the safaris of pal's choice is in cart.
    ${cartItemDescriptioins} =    Get Cart Item Descriptions
    Should Contain X Times    ${cartItemDescriptioins}       Herbivore Tour on 2025-03-19    1
    Should Contain X Times    ${cartItemDescriptioins}       T-Rex Rumble on 2025-03-19    1

Pals Items Are Added To Cart
    [Documentation]    This keyword executes and verifies adding pal's entrance ticket and 
    ...    the safaris of pal's choice to cart.
    Pal Buys Entrance Ticket
    Pal Books Safaris
    Pal Safaris Should Be Added To Cart
    Pal Entrance Ticket Should be Added To Cart
    
Dates For Pal Safaris Should Be Correct
    [Documentation]    This keyword verifies that the dates for pal's safaris are the same as expected.
    Dates for safaris in cart are the same and as expected    ${pal_expected_safari_date}
    

Dates for safaris in cart are the same
    [Documentation]    This keyword verifies that all safari dates in cart are the same.
    ${datesInCartList} =  Get Cart Item Dates
    ${listLength} =     Get Length    ${datesInCartList}
    FOR     ${i}    IN RANGE     0    ${listLength}
        Should Be Equal    ${datesInCartList}[0]    ${datesInCartList}[${i}]
    END

Dates for safaris in cart are the same and as expected
    [Documentation]    This keyword verifies that all safari dates in cart are the same as the date in argument.
    [Arguments]     ${expectedDate}
    ${datesInCartList} =  Get Cart Item Dates
    ${listLength} =     Get Length    ${datesInCartList}
    FOR     ${i}    IN RANGE     0    ${listLength}
        Should Be Equal    ${expectedDate}   ${datesInCartList}[${i}]
    END


Checkout Summary Alert Should Show Correct Pal Info
    [Documentation]    This keyword verifies that the checkout summary alert 
    ...    contains pal's order info.
    ${alert_text} =     Handle Alert    timeout=4 s
    Log    ${alert_text}
    Should Contain X Times    ${alert_text}    ${pal_ticket_description}    ${pal_number_of_tickets}
    Should Contain X Times   ${alert_text}    ${pal_safari1_description}    1
    Should Contain X Times    ${alert_text}    ${pal_safari2_description}    1
    Should Contain X Times    ${alert_text}    ${pal_total_desctiption}    1



### Misc ###

Total Cart Cost Should Be Correct
    [Documentation]    This keyword verifies that total cart cost is same as expected, by looping through cart, 
    ...    add all prices up, using javascript to fetch items in cart and their prices.  
    [Arguments]    ${expectedCost}
    ${cart} =    Execute JavaScript    return getCart();
    ${totalPriceInCart} =  Set Variable    0    
    ${cartLength} =     Get Length    ${cart}
    FOR     ${i}    IN RANGE     0    ${cartLength}
        ${tempItemPrice} =    Execute Javascript            
        ...    let item = ${cart}[${i}];
        ...    return item.price;
        ${totalPriceInCart}    Evaluate    ${totalPriceInCart} + ${tempItemPrice}
    END
    Should Be Equal As Numbers    ${totalPriceInCart}    ${expectedCost}

Get Cart Item Descriptions    
    [Documentation]    This keyword fetches a list of descriptions of all items in cart, 
    ...    using javascript to fetch items in cart and their respective descriptions.
    ...    (With more time, I would have liked a general "Get list by property" keyword)
    ${cart} =    Execute JavaScript    return getCart();
    ${cartLength} =    Get Length    ${cart}
    ${cartItemDescriptions} =    Create List
    FOR     ${i}    IN RANGE     0    ${cartLength}
        ${temp} =    Execute Javascript           
            ...    let item = ${cart}[${i}];
            ...    return item.description;
        Append To List    ${cartItemDescriptions}    ${temp}
    END
    RETURN    ${cartItemDescriptions}


Get Cart Item Dates
    [Documentation]    This keyword fetches a list of dates of all safaris in cart, 
    ...    using javascript to fetch items in cart and their respective dates.
    ${datesList} =  Create List 
    ${cart} =    Execute JavaScript    return getCart();
    ${cartLength} =     Get Length    ${cart}
    FOR    ${i}    IN RANGE    0    ${cartLength}
        ${temp} =     Set Variable    ''
        ${date} =     Execute Javascript
        ...    let item = ${cart}[${i}];
        ...    if (item.hasOwnProperty('date')){
        ...        return item.date;    
        ...    }
        ...    else {    
        ...        return "";   
        ...    }

        Run Keyword If    '${date}' != ''    Append To List   ${datesList}    ${date}
    END
    RETURN    ${datesList} 





