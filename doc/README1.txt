# Code Organization


## Overview 
Our project was coded in Ruby 1.9, using the Ruby on Rails 3.2 web framework.
Because of Rails's "convention over configuration" principle, all code needs
to be logically organized into specific folders, which will be briefly summarized
below. 

---

## How to Run
Rails programs can be run locally using the included WEBrick web server, which is
designed for debugging and development. A third party database system is necessary
to store data, although the SQLite3 file-based database can be used without explicitly
installing it through the "Gemfile". A few preliminary steps are needed in order
to configure a deployment machine with the necessary files and programs.

### Gemfile

The Ruby programming language has a native package manager called "Ruby Gems", invoked
from the command line using the "gem" command. Gems are the packages installed.
(Attempting to install gems on Windows can sometimes be complicated by the binaries
needing to be compiled natively instead of simply installed. We assume you have a *Nix
machine for this portion of the deployment.) A comprehensive list of all Gems needed
by the application for each mode of deployment is contianed in the Gemfile. To install
the prerequisite gems, run the following command:

	bundle install
	
### Database Creation and Migrations

Ruby on Rails is agnostic of the specific mode of relational database used by an application.
Its native Object-Relational Mapper, ActiveRecord, can perform all translations. Instead,
one installs a relevant Gem which translates between ActiveRecord and the active database.
In development modes, we use SQLite 3, which only needs the necessary gem mentioned in the 
Gemfile to run. However, because of Migrations, there are a few preparatory steps necessary
to run to initialize the database.

	rake db:create
	rake db:migrate
	
### Launch Development Servers

To launch the WEBrick server, invoke the following command:

	rails s

This launches the server in development mode on localhost:3000. 

---

## Code Organization

### app: 
Contains the majority of the working code of the application, including
static assets, helper functions, and the canonical Models, Views, and Controllers.

### config:
As the name suggests, contains the initializers, localizations, and environment
specifications needed to deploy in various modes. Of primary interst is the routes.rb
file, which defines the application's RESTful API.

### db:
Contains the schema.rb file, defining the layout of the database, the seeds.rb file,
containing the data collection initializers (currently empty), and most importantly
the migrate file with the migratinos.

### doc:
Contains the documentation for the application. The app folder contains the RDocs of the
application.

### lib:
Contains "tasks" folder for predefined tasks (soon to be populated) and "assets" for 
third-party code needed for our application, such as the "yfinadaptor.rb".

### log:

### public:
Contains various error pages as well as compiled CSS and JS.

### script: 
Contains scripts to be run.

### spec:
Contains testing scripts. We wrote our tests here, not in test.

### test:
Also contains scripting tests. We wrote our tests in spec, not in test.

### tmp:

### vendor:
A folder for third-party stylesheets and javascripts.