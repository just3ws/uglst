Feature: Opportunities
  Background:
    Given I am logged in as an admin

  Scenario: Admin can enter net opportunities
    When I go to the opportunity admin page
    Then I should be able to enter a new opportunity
