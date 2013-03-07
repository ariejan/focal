Feature: Import metrics from Pivotal Tracker
  As a user
  I want up-to-date metrics from Pivotal Tracker
  So the burndowns I look at are relevant

  Background:
    Given we fake Pivotal Tracker
    And a burndown for fake Pivotal Tracker exists

  Scenario: Burndown updates after metrics import
    Given I look a my burndown
    Then I can see sprint progress

    When the system imports metrics from Pivotal Tracker
    Then I can see my burndown was updated

