Feature: The executable creates files

  Scenario: creates an output file on completion
    When I run `parse_email_domains.rb`
    Then a csv output file should exist
