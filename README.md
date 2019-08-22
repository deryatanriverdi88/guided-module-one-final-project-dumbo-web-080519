# Random Meetup Finder
---
### Authors
  * [Derya Tanriverdi](https://github.com/deryatanriverdi88)
  * [Sukrit Walia](https://github.com/wukrit)

### Description
  Random Meetup Finder is a Ruby command line application. Random Meetup Finder seeds a SQLite3 database with information from Meetup.com's public API. Random Meetup Finder then allows users to view random group suggestions for them to join or skip. Users can browse a list of groups they have joined and view a list of upcoming events that the group is holding. Random Meetup Finder displays the location and date of these events and allows users to RSVP to an event and save the event to a list the user can access later. The meetup and group information Random Meetup Finder handles is persistent, allowing users to exit the application and still retrieve their data upon return.

### Installation
* In your bash terminal, navigate to the application directory and execute the following command to install the required ruby gems:

  `bundle install`

* Create a local database by running the following command in your terminal:

  `rake db:migrate`

* To seed data from Meetup.com API, execute the following command:

  `rake db:seed`

  **This command will destroy existing data in the SQLite3 database**

* To launch the application, execute:

  `ruby bin/run.rb`


---
* ##### [Link to Screenshots](https://github.com/deryatanriverdi88/guided-module-one-final-project-dumbo-web-080519/blob/master/SCREENSHOTS.md)
* ##### [Contributor Guidelines](https://github.com/deryatanriverdi88/guided-module-one-final-project-dumbo-web-080519/blob/master/CONTRIBUTING.md)
* ##### [License Information](https://github.com/deryatanriverdi88/guided-module-one-final-project-dumbo-web-080519/blob/master/LICENSE.md)
