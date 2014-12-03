Feature: Authentication
  Background:
    Given I have signed out

  Scenario: Visitor logs in
    Given I am a member with:
      | key      | value               |
      | Email    | member@ugtastic.com |
      | Password | password            |
      | Username | <EMPTY>             |
    When I visit the sign in page
    And I sign in with "member@ugtastic.com" and "password"
    Then I should see a notification "Signed in successfully."
    And I should see that my username is "Username?"
