Feature:
  In order to use the most of features of this website.
  A user which has signed up
  should fulfill his profile

    Scenario: User fulfill his profile
      Given I am logged in
      And I do not fulfill my profile
      When I fulfill my profile
      Then I see an success created message

    Scenario: User update his profile
      Given I am logged in
      And I have fulfilled my profile
      When I modify my profile
      Then I see an success updated message