Feature: User-Groups
  Background:
    Given I have signed out

  @skip
  Scenario: Login and go to register a User-Group
    Given I am a logged in user
    When I follow the "Register a User-Group!" link in the navbar
    Then I should see "Register a new User-Group"

  @skip
  Scenario: Register a User-Group
    Given I am logged in and on the User-Group registration form
    When I enter a new User-Group with:
      | key         | value                                   |
      | Name        | My User-Group                           |
      | Description | My awesome user-group description here. |
      | Topics      | ruby, testing, bdd                      |
      | Homepage    | http://www.example.com                  |
      | Twitter     | @ugtastic                               |
      | City        | Chicago                                 |
      | Country     | United States                           |
    And I click the "Save User-Group" button
    Then I should see "My User-Group"
    And I should see "Chicago, United States"
    And I should see "My User-Group Homepage"
    And I should see "bdd ruby testing"
    And the Twitter account for "My User-Group" is set to "ugtastic"
    And the Homepage for "My User-Group" is set to "http://www.example.com"


