# README
Note: Let Luke know that I found the commit message re: not forking the project.

### AUTHOR
Tom Kulmacz - June 14 2020


## DESCRIPTION
parse_email_domains.rb - is a command line utility that counts unique domains used in a CSV Email Column

Results are written to a CSV file in the root folder of the app.


### SYNOPSIS
From the root app folder:

Usage: bin/parse_email_domains.rb -v (-i <filepath> | -h | --version)

```
 bin/parse_email_domains.rb
 bin/parse_email_domains.rb -v
 bin/parse_email_domains.rb -i /home/sample.csv
```


###  OPTIONS
```
Specific options:
    -i, --input FILE                 Parse a specific CSV file: Provide a complete file path

Common options:
    -v, --verbose                    Run verbosely
    -h, --help                       Show help message
        --version                    Show version
```


### OUTPUT
The output file is created in the root folder of the app.

`output_{timestamp}.csv`


## TEST
Testing is done with Aruba/Cucumber for integration and Rspec for unit. The tmp folder is used for writing to during testing.
* Integration: `rake features`
* Unit tests: `rake spec`
* Both types: `rake spec features`


## Exit Codes
* 0 - Success
* 1 - Invalid command line option
* 2 - Missing command line Argument
* 3 - Source CSV not found
* 4 - Insufficient permissions to read source CSV
* 5 - Malformed CSV Error in source CSV
* 6 - Insufficient permissions to write results CSV


## Future Improvements
* Add option for generating a new file on demand with a file path and optional line count
* Add option for sorting the results
* Add option for CSV column that contains email address
* Add option for passing an output directory and file name
* Use sqlite instead of results Hash in ParseCSV
* Adding different output templates


# TASK DESCRIPTION
This project has a CSV file that we need some data extracted from. We want to generate a count of how often different domains are being used in email addresses. There is a single spec that should demonstrate what we need.


## Directions
You can change anything you want except for the roster.csv file. You can rewrite the specs, anything in lib and you can even add gems if you think that might be helpful. You don't need to change anything if you think the existing structure is good.

Here's what I'll be thinking about when I look at your solution:

* is the coding style consistent?
* is the ruby idiomatic and easy to understand?
* are things that change quickly isolated from things that won't?
* are there concepts that have been made clearer in the way you solved the problem?
* are the solution and specs efficient?
* are the commit message(s) informative?

There isn't a single correct solution to the problem. I've purposely made the problem relatively easy to solve, so that you can focus on all the other stuff. I'm eager to see your solution and I'm also eager to hear about your experience writing the code. Let me know once your solution is done. If you like, I will offer you some feedback which you could incorporate.
