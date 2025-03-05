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

Message Should Be Visible
    [Arguments]    ${error_message_element}    ${error_message_text}    ${timeout}    ${good_mess}
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${good_mess}
    Sleep    2
    Wait Until Element Is Visible    ${error_message_element}    ${timeout}
    Element Text Should Be    ${error_message_element}    ${error_message_text}

User Should Recieve Alert
    [Documentation]    This keyword verifies message of an alert box.
    [Arguments]    ${expected_alert_text}
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${expected_alert_text}

Message Should Be Displayed
    [Documentation]    This keyword verifies that a specific element contains a specific message.  
    [Arguments]    ${element}    ${message}
    Wait Until Element Is Visible    ${element}    ${standard_timeout}
    SeleniumLibrary.Element Text Should Be    ${element}    ${message}

User Should Get Message That Username Already Exists
    Message Should Be Displayed    ${reg_message_element}    ${reg_error_message_already_exists}

User Should Get Message That Only VIP User Can Book VIP Safaris
    Message Should Be Displayed    ${safari_message_element}    ${safari_VIP_error_message}

User Should Get Message That VIP Ticket Is Required
    Message Should Be Displayed   ${safari_message_element}    ${safari_weekend_without_VIP_error_message}