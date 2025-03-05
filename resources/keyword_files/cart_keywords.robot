*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ${keywords_path}/login_and_registration_keywords.robot
Resource    ${keywords_path}/button_and_navigation_keywords.robot

Variables    ${util_path}/variables.py


*** Variables ***
${html_path}    file://${EXECDIR}/website/jurap.html_path"
${keywords_path}    ${EXECDIR}/resources/keyword_files
${resource_path}    ${EXECDIR}/resources
${util_path}    ${EXECDIR}/resources/util


*** Keywords ***

Check Shopping Cart Total
    [Arguments]    ${expected_total}    ${cart_tab}    ${cart_total_xpath}
    Click Specific Button    ${cart_tab}
	${actual_text}    Get Text    ${cart_total_xpath}
	Should Contain    ${actual_text}    ${expected_total}

Check Cart Items Order Info
    [Arguments]    ${item_to_check}    ${expected_text}    ${cart_tab}    ${cart_list_xpath}
	
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

Cart Should be Empty
    [Documentation]    This keyword verifies that cart is empty.
    ${cart} =    Execute JavaScript    return getCart();
    Should Be Empty    ${cart}

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