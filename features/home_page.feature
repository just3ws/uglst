Feature: Visit home page to explore User-Groups
  In order to explore User-Groups
  As an anonymous user 
  I want to see a list of User-Groups

  Scenario: Starting fresh 
    Given I am not logged in
    And there are no User-Groups registered
    When I'm on the home page
    Then show me the page
    Then I should see nothing



