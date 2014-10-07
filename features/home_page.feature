Feature: Visit home page to explore User-Groups
  In order to explore User-Groups
  As an anonymous user 
  I want to see a list of User-Groups

  Scenario: View the home page before any User-Groups have been registered
    Given I am on the home page
    When no User-Groups exist
    Then I should see "No User-Groups have been registered. Register one today!"
