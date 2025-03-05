
# Group 2: Wille, Johan, Kristin 
# This file is created, tested, refactored by Kristin

*** Settings ***

Library    SeleniumLibrary

Resource    ../resources/keyword_files/keywords.robot
Resource    ../resources/keyword_files/pal_keywords.robot

Variables    ../resources/util/variables.py
Variables    ../resources/util/pal_specific_variables.py

Test Setup    Setup Suite Open Page
Test Teardown    Teardown Suite

*** Test Cases ***
Register User Pal
    [Documentation]    This test verifies the registration process for user pal.
    [Tags]    Kristin    Registration    Credentials    pipeline-testing
    Given Page Is Opened To Registration Section
    When User Pal Enters Registration Credentials
    And User Presses Submit Registration Button
    Then User Pal Should be Registered    
    
Log In User Pal
    [Documentation]    This test verifies the login process for user pal.
    [Tags]    Kristin    Login    Credentials
    Given User Pal Is Registered
    And Page Is Opened To Login Page
    And No One Is Logged In
    When User Pal Enters Login Credentials
    And User Presses Login Submit Button
    Then User Pal Should Be Logged In

Pal Buys Entrance Ticket
    [Documentation]    This test verifies that pal can buy entrance ticket when logged in,
    ...    that item is added to cart, and cart total is correct.
    [Tags]    Kristin    Ticket    BookingProcess    Cart    CostTotal    Demo
    Given User Pal Is Logged In
    When Pal Buys Entrance Ticket
    Then Pal Entrance Ticket Should be Added To Cart
    And Total Cart Cost Should Be Correct    ${50}

Pal Books Safaris
    [Documentation]    This test verifies the safari booking process for user pal, 
    ...    and that cart total price is correct.
    [Tags]    Kristin    Safari    BookingProcess    Cart    CostTotal    Demo
    Given User Pal Is Logged In
    And Pal Entrance Ticket Is Added To Cart
    When Pal Books Safaris 
    Then Pal Safaris Should Be Added To Cart
    And Dates For Pal Safaris Should Be Correct
    And Total Cart Cost Should Be Correct    ${320}

Pal Checks Out
    [Documentation]    This test verifies the checkout process for user pal, and that summary is correct.
    [Tags]    Kristin    Cart    CostTotal    Checkout    Dates    Summary    Demo
    Given User Pal Is Logged In
    And Pals Items Are Added To Cart
    When User Presses Proceed To Checkout
    Then Checkout Summary Alert Should Show Correct Pal Info
    And Cart Should be Empty
