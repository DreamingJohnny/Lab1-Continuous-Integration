
*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String

Resource    ${keywords_path}/button_and_navigation_keywords.robot
Variables    ${util_path}/variables.py


*** Variables ***
${html_path}    file://${EXECDIR}/website/jurap.html_path"
${keywords_path}    ${EXECDIR}/resources/keyword_files
${resource_path}    ${EXECDIR}/resources
${util_path}    ${EXECDIR}/resources/util

*** Keywords ***

User Enters Registration Credentials
    [Documentation]    This keyword enters username and password into registration fields.
    [Arguments]    ${username}    ${password}
    Input Credentials    ${username}    ${reg_username_text_box}    ${password}    ${reg_password_text_box}

User Enters Login Credentials
    [Tags]
    [Documentation]    This keyword enters username and password into login fields.
    [Arguments]    ${username}    ${password}
    Input Credentials    ${username}    ${login_username_text_box}    ${password}    ${login_password_text_box}

User Registers Username
    [Documentation]    This keyword executes registration process of user, without verification.
    [Arguments]    ${username}    ${password}
    User Navigates To Register Section
    Page Is Opened To Registration Section
    User Enters Registration Credentials    ${username}    ${password}
    Press Register Submit Button

User Should Be Registered
    [Documentation]    This keyword verifies that user is registerd as a user,
    ...    by fetching list of users with javascript and finding username in list.
    [Arguments]    ${username}
    ${userRegistered} =    Execute JavaScript    
    ...    let users = getUsers();
        ...    return users.some(u => u.username === '${username}');
    Should Be True    ${userRegistered}

User Is Registered
    [Documentation]    This keyword executes and verifies user registration.
    [Arguments]    ${username}    ${password}    
    User Registers Username    ${username}    ${password}
    User should be registered    ${username}

User Is Logged In
    [Documentation]    This keyword executes and verifies user registration and login.
    [Arguments]    ${username}    ${password}
    User Is Registered    ${username}    ${password}
    Log In User    ${username}    ${password}   
    User Should Be Logged In    ${username}

Log In User
    [Documentation]    This keyword executes and verifies user login.
    [Arguments]    ${username}    ${password}
    User Navigates To Login Section
    User Enters Login Credentials    ${username}    ${password}
    User Presses Login Submit Button
    Wait Until Page Contains Element    ${logout_button}
    User Should Be Logged In    ${username}

User Should Be Logged In
    [Documentation]    This keyword verifies that user is logged in,
    ...    by using javascript to fetch the username of the current logged in user.
    [Arguments]    ${username}
    ${UserLoggedIn} =    Execute JavaScript    return currentUser.username;
    Should Be Equal    ${UserLoggedIn}    ${username}

No One Is Logged In
    [Documentation]    This keyword verifies that no user is currently logged in. If any user is logged in, user is logged out.
    ${userLoggedIn} =     Execute Javascript    if (currentUser) { return true; } else { return false; }
    Run Keyword If    ${userLoggedIn}    Log Out User
    Login Button Should Be Visible

Log Out User
    [Documentation]    This keyword executes and verifies user logout.
    Press Logout Button
    ${alert_text}    Handle Alert    action=DISMISS
    Should Contain    ${alert_text}    ${logout_message}
    Wait Until Element Is Visible    ${login_button}


######### From original keyword file #########


Input Credentials
    [Arguments]    ${username}    ${username_space}    ${password}    ${password_space}
    Input Text    ${username_space}    ${username}
    Input Text    ${password_space}    ${password}

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

The User Is Logged In To Their Account
    [Arguments]    ${login_tab}    ${username}    ${password}    ${username_field}    ${password_field}    ${submit_login_button}
	Click Specific Button    ${login_tab}
	Input Credentials    ${username}    ${username_field}    ${password}    ${password_field}
	Click Specific Button    ${submit_login_button}
	Sleep    3

## Not used, cannot press register, is alerted "fyll i det här fältet" first
User Enters Only Username And No Password
    Input Text    ${reg_username_text_box}    ${valid_username}

User Enters Only Password And No Username
    Input Credentials    ${None}    ${reg_username_text_box}    ${valid_password}    ${reg_password_text_box}