Feature: Profiles
  Background:
    Given I have signed out

  Scenario: User can sign in and manager their profile
    Given I have already signed up with "mike@ugtastic.com"
    When I open my profile page from the nav bar
    And create a profile with:
      | key        | value                                         |
      | First name | Mike                                          |
      | Last name  | Hall                                          |
      | Bio        | This is an example bio.                       |
      | Homepage   | http://www.ugtastic.com                       |
      | Twitter    | @ugtastic                                     |
      | Address    | 101 North Main Street, Crystal Lake, IL 60014 |
    And submit the profile info form
    Then navigate to my public profile page
    And I should see a profile with:
      | key        | value                                         |
      | Name       | Mike Hall                                     |
      | Address    | Crystal Lake, Illinois US                     |
      | Bio        | This is an example bio.                       |

  Scenario: User can update their username
    Given I have already signed up with "mike@ugtastic.com"
    When I open my profile page from the nav bar
    Then I should see a warning "Looks like your username is blank."

    When I click the button to set my username
    And I update my username with "thisisatest"
    And submit the account info form
    Then I should see that my username is "thisisatest"

    #And update my account info:
      #| key        | value                                         |
      #| Username   | ugtastic                                      |
      #| Email      | test@example.com                              |
    #And submit the account info form
    #Then navigate to my public profile page
    #And I should see a profile with:
      #| key        | value                                         |
      #| Name       | Mike Hall                                     |
      #| Address    | Crystal Lake, Illinois US                     |
      #| Bio        | This is an example bio.                       |

