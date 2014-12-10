Feature: Opportunities

  Scenario: Admin can enter net opportunities
    Given I am logged in as an admin
    When I go to the opportunity admin page
    Then I should see there are no opportunities

  @skip
  Scenario: Send non logged in users to login
    Given I have signed out
    When I go to the opportunity admin page
    Then I should be redirected to the login page
