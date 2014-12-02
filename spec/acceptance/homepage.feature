Feature: Homepage
  Background:
    Given I have signed out

  @skip
  Scenario: Sign up a visitor from the homepage
    When I visit the homepage
    And register with:
     | key                   | value            |
     | Email                 | test@example.com |
     | Password              | password         |
     | Password Confirmation | password         |
   And submit the registration form
   Then I should see the UserGroup Index
   And a welcome message
