Feature: The executable has a good command-line interface

  Scenario: Checking that the options are documented
    When I run `parse_email_domains.rb -h`
    Then the output should contain:
    """
    Usage: parse_email_domains.rb -v (-i <filepath> | -h | --version)
    """

  Scenario: Prints messages in verbose mode
    When I run `parse_email_domains.rb -v`
    Then the output should contain:
    """
    results saved in file:
    """

  Scenario: Prints messages in verbose mode
    When I run `parse_email_domains.rb --version`
    Then the output should contain:
    """
    1.0.0
    """
