Feature: The executable provides correct success status

Scenario: When running with unsupported switches
  When I run `parse_email_domains.rb --bad`
  Then the exit status should be 1

Scenario: When running with missing arguments
  When I run `parse_email_domains.rb --input`
  Then the exit status should be 2

Scenario: When running on a file that doesn't exist
  When I run `parse_email_domains.rb -i file_does_not_exist.csv`
  Then the exit status should be 3

  Scenario: When running on a file that doesn't have read permission
    Given a file that is unreadable
    When I run `parse_email_domains.rb -i unreadable.csv`
    Then the exit status should be 4

Scenario: When running on a malformed csv
  When I run `parse_email_domains.rb -i ../../spec/fixtures/malformed.csv`
  Then the exit status should be 5

Scenario: When writing the output to a dir without write permission
  Given a folder that is not writeable
  When I run `parse_email_domains.rb`
  Then the exit status should be 6
