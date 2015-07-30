Victor test
============

test project for Victor

------
Short description of tools and used frameworks

  Project contain 2 part:
  
   1. Cucumber based framework for WEB testing   
    For implementation automation scenarious was used Cucumber as a framework, 
    selenium webdriver as a driver, Capybara + SitePrism - page object solution.
    Tests could be run on Firefox or Chrome browser.
    For test report was used Cucumber native solution.
    And of course Ruby as a programming language.
    
   2. RSpec based framework for API testing 
     For API testing was chosen RSpec and airborne as a wrapper for convenient 
     expectations. Also was used library for authentication provided by company.
   
------
Requirements

1. ruby 2.2.1 or higher
2. preinstalled gems 
[ You could install all neccessary gems by using next commands:
gem install bundler
*navigate to root folder of the project with 'Gemfile' file*
bundle install ]
3. installed browser - Firefox or Chrome
4. internet connection =)

------
Manual

For running both API and WEB tests you could use rake tasks.
Navigate to the root project directory and run command "rake". It will initiate running all scenarios one by one. 
You could run them separate by using parameters "web" or "api". 
Just add after command "rake" parameter, like this "rake web" or "rake api".

Also you have chance to use native commands instead of rake. In this case follow the directions below.

For WEB tests:
Navigate to the root project directory and run command "cucumber".
All test will be run using Chrome browser. 
For running tests on Firefox browser you could use next command "cucumber DRIVER=firefox".
Report you could find in 'report' folder. It is 'report.html' file which updates after each run.

For API tests:
Navigate to the root project directory and run command "rspec spec/*". All test will be run. 

