Feature: Homepage

  Background:
    Given I have signed out

  @skip
  Scenario: A new visitor signs up from the homepage
    When I visit the homepage
    And I fill out the registration form with:
      | key                   | value            |
      | Email                 | test@example.com |
      | Password              | password         |
      | Password confirmation | password         |
    And I submit the registration form
    Then I should see a notification "Welcome! You have signed up successfully."
    And I should see the User-Group Index
    And I see the User-Group Index is empty
    And I should see that my username is "Username?"
    And I should see a warning "Looks like your username is blank."
