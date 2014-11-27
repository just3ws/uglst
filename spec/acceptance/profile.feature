Feature: Profile
  Background:
    Given I have signed out

  Scenario: User can sign in and manager their profile
    Given I have already signed up with "mike@ugtastic.com"
    When I open my profile page from the nav bar
    And update my account info:
      | key        | value                                         |
      | Username   | ugtastic                                      |
      | Email      | test@example.com                              |
    And create a profile with:
      | key        | value                                         |
      | Username   | ugtastic                                      |
      | First name | Mike                                          |
      | Last name  | Hall                                          |
      | Bio        | This is an example bio.                       |
      | Homepage   | http://www.ugtastic.com                       |
      | Twitter    | @ugtastic                                     |
      | Address    | 101 North Main Street, Crystal Lake, IL 60014 |
    And submit the account info form
    And visit my profile page
    Then I should see a profile with:
      | key        | value                                         |
      | Name       | Mike Hall                                     |
      | Address    | Crystal Lake, Illinois US                     |
      | Bio        | This is an example bio.                       |

