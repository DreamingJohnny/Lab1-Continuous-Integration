import os
import tempfile

current_directory = os.getcwd().replace('\\', '/')


html_path = "file://${EXECDIR}/website/jurap.html_path"
resource_path = "${EXECDIR}/resources"
browser_new_options = "--headless"

#Site specifics
temp_dir = tempfile.mkdtemp()
browser = "headlesschrome"
browser_options =  "--headless --disable-gpu --incognito --user-data-dir=${temp_dir}"

url_demo = f"file:///{current_directory}/webpage\jurap.html"
title_demo = "Jura-Stina-Kalle Park"

#Sections
home_section = "id=home-section"
login_section = "id=login-section"
reg_section = "id=register-form"
tickets_section = "id=tickets-section"
safari_section = "id=safari-section"
cart_section = "id=safari-section"

#Login specifics
login_button = "login-nav"
login_username_text_box = "login-username"
login_password_text_box = "login-password"

#Valid login
valid_username = "testUser2"
valid_password = "testPassword2"
verifying_message = "Verifying credentials..."
login_submit_button = "xpath=/html/body/main/article[3]/section/form/button"

#Invalid login
invalid_username = "XXXXXXXX"
invalid_password = "YYYYYYYY"
error_message_element_demo = "id=login-message"
error_message_demo = "Invalid username or password."

#Logout specifics
logout_button = "logout-nav"
logout_message = "You have been logged out."

#Registration
reg_button = "xpath=/html/body/header/div/nav/ul/li[2]/a"
reg_username_text_box = "reg-username"
reg_password_text_box = "reg-password"
reg_submit_button = "xpath=/html/body/main/article[2]/section/form/button"
reg_message_element = "id=register-message"
reg_success_message = "Registration successful! Redirecting to login..."
reg_error_message_already_exists = "Username already exists. Please choose another."
reg_error_empty_field = "Please enter both a username and password."
reg_error_password_too_short = "Password must be at least 8 characters long."

#Misc
standard_timeout = "5s"
logout_button = "logout-link"

#Buying tickets
buy_ticket_button = "xpath=/html/body/header/div/nav/ul/li[4]/a"
ticket_type_field = "id=ticket-type"    #"xpath=/html/body/main/article[4]/section/form/select[1]"
adult_ticket_type = "Adult"
regular_adult_ticket_price = "50"
child_ticket_type = "Child"
regular_child_ticket_price = 30
senior_ticket_type = "Senior"
ticket_cat_field = "id=ticket-category"     #"xpath=/html/body/main/article[4]/section/form/select[2]"
regular_ticket = "Regular"
vip_ticket = "VIP"
vip_adult_ticket_price = 100
vip_child_ticket_price = 60
add_to_cart_button = "xpath=/html/body/main/article[4]/section/form/button"
add_to_cart_message_successful = "Item added to cart!"
input_of_ticket_counter = "id=ticket-quantity"
cart_nav_button = "xpath=/html/body/header/div/nav/ul/li[6]"
pro_to_checkout_button = "xpath=/html/body/main/article[6]/section/button"
ticket_login_error_message = "You must be logged in to purchase tickets."

#Booking safaris
safari_button = "xpath=/html/body/header/div/nav/ul/li[5]/a"
safari_date_field = "id=safari-date"
date_for_booking = "002026-02-20"
safari_date_weekend = "002026-02-21"
safari_date_weekday = "002026-02-20"
safari_expected_date_weekend = "2026-02-21"
safari_expected_date_weekday = "2026-02-20"
safari_type_field = "xpath=/html/body/main/article[5]/section/form/select"
safari_type_herbivor_tour = "Herbivore Tour"
safari_type_t_rex_rumble = "T-Rex Rumble"
safari_type_herbivor_tour_feeding = "Herbivore Tour with Feeding"
safari_herbivor_tour_feeding_price = 180
safari_type_t_rex_rumble_thrill = "T-Rex Rumble eXtreme Thrill Pack"
safari_t_rex_rumble_thrill_price = 220
safari_submit_button = "xpath=/html/body/main/article[5]/section/form/button"
safari_message_element = "id=safari-message"
safari_VIP_error_message = "Only VIP users can book the selected safari option."
safari_weekend_without_VIP_error_message = "VIP tickets required to book safaris on weekends."
safari_login_error_message = "You must be logged in to book a safari."

#Removing from cart
first_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[1]/button"
second_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[2]/button"

#Shopping cart
cart_total_xpath = "xpath=//*[@id=\"cart-total\"]"

cart_tab_xpath = "xpath=//*[@id=\"cart-nav\"]"

cart_list_xpath = "xpath=//*[@id=\"cart-details\"]/ul/li"

proceed_to_checkout_button = "xpath=//*[@id=\"checkout-button\"]"

#Wille VG Variables

#Ticket check variables
vip_ticket_in_cart_spot =    "id=cart-details"
vip_ticket_in_cart = "1 VIP Adult Ticket(s) - $100"

#safari Check variables
trex_rumble_in_cart = "T-Rex Rumble on"
herbivor_in_cart = "Herbivore Tour on"
herbivorplus_in_cart = "Herbivore Tour with Feeding"
trex_rumbleplus_in_cart = "T-Rex Rumble eXtreme Thrill Pack"

all_combinations_cost = "1260"
reg_ticket_trex_rumble_safari = "200"
all_combinations_safari_cost = "770"