Feature: Home page

  Scenario: Starting fresh
    Given I am not logged in
    And there are no User-Groups registered
    When I'm on the home page
    Then I should see nothing

  Scenario: Visitor wants to register a User-Group
    Given I am not logged in
    And there are no User-Groups registered
    And I'm on the home page
    When I click "Register your User-Group"
    Then I should see the login page

    When I click "Sign up"
    Then I should see the sign up page
    And I sign up
    And show me the page


