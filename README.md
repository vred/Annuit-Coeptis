# Capital Games

######"Annuit-Coeptis"

This is a working (private) development repository for Professor Marsic's Software Engineering Spring 2013 Class, Team 2.
Entitled "Capital Games," this project will utilize the rails framework to create an online stock market fantasy platform
for generating and participating in fantasy stock market leagues. Full docs are included in the
"doc" folder.

"Annuit Coeptis," or "he favors our endeavors," is printed on the back of every dollar bill.

## Update Log 2/10/2013

Jeff Rabinowitz created an empty Rails 3 application using Ruby 1.9.3 and pushed it to the server.
We could technically use Rails 4 and Ruby 2.0, butttttt it came out on Thursday and nothing supports it yet,
so let's just stick with 1.9.3 for now.

---

## Update Log 3/21/2013

Val is currently working on converting the Finance API to change it from string format to hash format.
Jayrab is building validation into the models and stubbing out the controllers and views. Eric is
going over the Bootstrap theme purchased and converting it into Rails for our application. Jadler is
configuring the server backend and researching Resque/cron functionality. Nick is playing with Highcharts
and Dario is eating catfish.

### Major Changes

The Models are being overhauled to use Money class objects and have internal counting built in. Also
RSpec unit tests and Capybara integration tests are being designed, although they aren't thorough
enough for full production. They should, however, be good enough to not allow any unexpected crashes.

---

## Update Log 4/7/2013

