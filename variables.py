import os

current_directory = os.getcwd().replace('\\', '/')
#Site specifics
browser = "chrome"
url_demo = f"file:///{current_directory}/Homepage\jurap.html"
title_demo = "Jura-Stina-Kalle Park"
#Login specifiks
login_button = "login-nav"
login_username_text_box = "login-username"
login_password_text_box = "login-password"
#Valid login
valid_username = "testUser2"
valid_password = "testPassword2"
verifying_messege = "Verifying credentials..."
login_submit_button = "xpath=/html/body/main/article[3]/section/form/button"
#Invalid login
invalid_username = "XXXXXXXX"
invalid_password = "YYYYYYYY"
error_message_element_demo = "id=login-message"
error_message_demo = "Invalid username or password."
#Registration
reg_button = "xpath=/html/body/header/div/nav/ul/li[2]/a"
reg_username_text_box = "reg-username"
reg_password_text_box = "reg-password"
reg_submit_button = "xpath=/html/body/main/article[2]/section/form/button"
#Misc
standard_timeout = "5s"
logout_button = "logout-link"
#Buying tickets
buy_ticket_button = "xpath=/html/body/header/div/nav/ul/li[4]/a"
ticker_type_field = "xpath=/html/body/main/article[4]/section/form/select[1]"
adult_ticket_type = "Adult"
child_ticket_type = "Child"
senior_ticket_type = "Senior"
ticket_cat_field = "xpath=/html/body/main/article[4]/section/form/select[2]"
regular_ticket = "Regular"
vip_ticket = "VIP"
add_to_cart_button = "xpath=/html/body/main/article[4]/section/form/button"
input_of_ticket_counter = "id=ticket-quantity"
cart_nav_button = "xpath=/html/body/header/div/nav/ul/li[6]"
pro_to_checkout_button = "xpath=/html/body/main/article[6]/section/button"
#Buying safaris
safari_button = "xpath=/html/body/header/div/nav/ul/li[5]/a"
safari_date_field = "id=safari-date"
date_for_booking = "002025-02-20"
safari_type_field = "xpath=/html/body/main/article[5]/section/form/select"
safari_type_herbivor_tour = "Herbivore Tour"
safari_type_t_rex_rumble = "T-Rex Rumble"
safari_type_herbivor_tour_feeding = "Herbivore Tour with Feeding"
safari_type_t_rex_rumble_thrill = "T-Rex Rumble eXtreme Thrill Pack"
safari_submit_button = "xpath=/html/body/main/article[5]/section/form/button"
#Removing from cart
first_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[1]/button"
second_object_in_cart = "xpath=/html/body/main/article[6]/section/div/ul/li[2]/button"
#Wille VG Variables

#Ticket check variables
vip_ticket_in_cart_spot =    "id=cart-details"
vip_ticket_in_cart = "1 VIP Adult Ticket(s) - $100"

#safari Check variables
trex_rumble_in_cart = "T-Rex Rumble on"
herbivor_in_cart = "Herbivore Tour on"
herbivorplus_in_cart = "Herbivore Tour with Feeding"
trex_rumbleplus_in_cart = "T-Rex Rumble eXtreme Thrill Pack"

                       

                       
                       
