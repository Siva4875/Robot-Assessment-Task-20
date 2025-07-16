*** Settings ***
# General documentation for this test suite
Documentation    List of Test cases for the SauceDemo website.
...    Test Case 1 - Login With Valid Credentials 
...    Test Case 2 - Login With Invalid Credentials 
...    Test Case 3 - Add Single Product To Cart  
...    Test Case 4 - Checkout With Multiple Products

# Load necessary libraries for browser automation and data handling
Library          SeleniumLibrary
Library          Collections
Library          String

# Automatically open the webpage before each test case
Test Setup       Open Webpage URL    ${browser_name}    ${webpage_url}

# Automatically close the browser after each test case
Test Teardown    Close The Browser

# Load Python variable files containing element locators and test data
Variables        ../Resources/PageObject/Locators/test_locators.py
Variables        ../Resources/PageObject/TestData/test_data.py

# Load reusable keyword definitions from different page object files
Resource         ../Resources/PageObject/KeywordDefinitionFiles/generic.robot
Resource         ../Resources/PageObject/KeywordDefinitionFiles/loginpage.robot
Resource         ../Resources/PageObject/KeywordDefinitionFiles/inventorypage.robot
Resource         ../Resources/PageObject/KeywordDefinitionFiles/cartpage.robot

*** Test Cases ***

# Test Case 1 - Valid login flow
# Verifies that the user can log in with correct credentials and reach the inventory page
Test Case 1 - Login With Valid Credentials
    Login Into The Webpage

# Test Case 2 - Invalid login flow
# Tries logging in with incorrect credentials and checks for error message
Test Case 2 - Login With Invalid Credentials
    Enter User Credentials And Login    ${invalid_username}    ${invalid_password}
    Verify Notification Message         ${login_error_element}    ${invalid_login_error_message}

# Test Case 3 - Add single product to cart
# Logs in, adds a single item to the cart, navigates to the cart page, and verifies it is added
Test Case 3 - Add Single Product To Cart
    # Login to the webpage
    Login Into The Webpage
    # Add one item to the cart
    Add Items To Cart                  ${cart_item}
    # Navigate to the cart page
    Go To Cart
    # Confirm the item appears in the cart
    Verify Items In Cart              ${cart_item}

# Test Case 4 - Add multiple products and proceed to checkout
# Logs in, adds multiple items to cart, navigates to cart, and verifies items before checkout
Test Case 4 - Checkout With Multiple Products
    # Login to the webpage
    Login Into The Webpage
    # Add multiple items to the cart
    Add Items To Cart                  ${cart_list}
    # Navigate to the cart page
    Go To Cart
    # Confirm all selected items appear in the cart
    Verify Items In Cart              ${cart_list}
