Feature: Authentication
  Background:
    Given I have signed out

  Scenario: Visitor logs in
    Given I am a member with:
      | key      | value               |
      | Email    | member@example.com |
      | Password | password            |
      | Username | <EMPTY>             |
    When I visit the sign in page
    And I sign in with "member@example.com" and "password"
    Then I should see a notification "Signed in successfully."
    And I should see that my username is "Username?"

  Scenario: Admin logs in
    Given I am an admin
    When I visit the sign in page
    And I sign in with "admin@example.com" and "password"
    Then I should see a notification "Signed in successfully."
    And I should see that my username is "admin"
