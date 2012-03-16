Feature:
  I am a user and want to create my club and manage it

  Scenario: I have signed up but not fulfill profile
    Given I am logged in
    And I am not fulfill my profile
    When I watch create new club page
    Then I see an need to fulfill profile message