Feature: Profile
  Background:
    Given I have signed out

  @javascript
  Scenario: User can sign in and manager their profile
    Given I have signed up with "mike@ugtastic.com"
    And I open my profile page from the nav bar
    When I create a profile with:
      | key        | value                                         |
      | First name | Mike                                          |
      | Last name  | Hall                                          |
      | Bio        | This is an example bio.                       |
      | Homepage   | http://www.ugtastic.com                       |
      | Twitter    | @ugtastic                                     |
      | Address    | 101 North Main Street, Crystal Lake, IL 60014 |
    #Then I should see a profile with:
      #| key        | value                                         |
      #| Name       | Mike Hall                                     |
      #| Address    | Chicago, IL US                                |
      #| Bio        | This is an example bio.                       |

