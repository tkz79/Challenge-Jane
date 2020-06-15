Feature: The executable provides correct success status

Scenario: When running with no params
  When I run `parse_email_domains.rb`
  Then the exit status should be 0

Scenario: When checking the options
  When I run `parse_email_domains.rb --help`
  Then the exit status should be 0

Scenario: When checking the options
  When I run `parse_email_domains.rb -h`
  Then the exit status should be 0

Scenario: When running with --version option
  When I run `parse_email_domains.rb --version`
  Then the exit status should be 0

Scenario: When running with -v option
  When I run `parse_email_domains.rb -v`
  Then the exit status should be 0

Scenario: When running with --verbose option
  When I run `parse_email_domains.rb --verbose`
  Then the exit status should be 0

Scenario: When running with -i option
  When I run `parse_email_domains.rb -i ../../spec/fixtures/mini_roster.csv`
  Then the exit status should be 0

Scenario: When running with --input option
  When I run `parse_email_domains.rb --input ../../spec/fixtures/mini_roster.csv`
  Then the exit status should be 0
