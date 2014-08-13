# Scot's Sample Ruby App

#### NOTE: I am only writing this for my own goddamn benefit. If it helps anybody else along the way...fine. 

##### Links:
* [Latest Heroku Deployment Of This Project](http://agile-dawn-6413.herokuapp.com)
* [Using RoR 3 Tutorial by Michael Hartl](http://www.railstutorial.org/)

***

# INITIAL SETUP

##Initialize new application without default tests
```
$ rails new sample_app -T
```
# Configure Gemfile for heroku deployment:

```
group :development do
	gem 'sqlite3' # will not work in heroku
	gem 'rspec-rails'
end

group :production do
	gem 'pg' #needed for heroku
	gem 'rspec'
	gem 'webrat'
end

gem 'rails_12factor' # needed for heroku
```

Also, create a new file public/index.html as there is no default root route for production
set by the 'rails new' command. It will work on your local system but not on heroku. Creating the index.html
file is just so it will quickly deploy successfully. Once a controller is made I am going to remove it.

Once all of this is done, init a git repository and commmit

Then:
```
$ rake db:migrate
```
To run development:
```
$ rails s
```
open browser to localhost

To run production:
```
$ heroku create
$ git push heroku master
```
once this is finished:
```
$ heroku open 
```
or copy the given url into the browser. Should see contents of index.html page that was created in /public. 

after this run:
```
$ heroku run rake db:setup
$ heroku rake db:migrate
```
Start developing your models and shit.

***

# STATIC PAGES

To generate some static pages type:
```
$ rails generate controller Pages home contact
```
This will add a pages_controller for the pages/home and pages/contact endpoints. 
If rspec is in Gemfile it should generate a /spec/ files for these pages. 

This command generates these files/content when the generage command executes
controllers/pages_controler.rb:
	def home
	end
	def contact
	end
config/routes.rb:
	get 'pages/home'
	get 'pages/contact'
views/pages/home.html.erb (contains dummy html)
views/pages/contact.html.erb (contains dummy html)

###NOTE: to manually add a static page, must create all of the above. Also need to make a test/tests for that
page in the spec/controllers/%correct_controller_spec%.rb file.

Once the controller is created add

```
root 'pages#home'
```

to the routes.rb and delete /public/index.html. This should set /pages/home to be the root.

## DRY embedded ruby

For each of the static pages, write the embedded html content for the body tag only. In layouts/application.html.erb,
define the base html that is common to all of the pages. Use the <%= yield %> tag in the body to inject correct 
content from the individual page html.erb files.

***

# TESTS - using rspec, growl, and autotest

##Test Frameworks Being Used
* Growl - Mac App for notifications (Install from App Store now - $3.99)
* rspec - rails test framework
* autotest .... not sure yet

```
$ gem install autotest
$ gem install autotest-rails-pure
$ gem install autotest-fsevent
$ gem install autotest-growl
```

make ~/.autotest file and fill it with:

```
require 'autotest/growl'
require 'autotest/fsevent'
```

At this point should be able to run 

```
$ rspec spec/ 
```

This will run all tests in the /spec folder.

I had issues at this point and needed to run:

```
$ bin/rails generate rspec:install
```

to re-generate my 'spec_helper' and 'rails_helper' files. For some reason they did not exist
with my installation of rspec? Not sure. Either way it works.

running ```$autotest``` does not yet work however...neither does growl notifications.

***

# ISSUES

#####Heroku ssh issue with connection
	I am using multiple ssh keys on my system and by default it uses the id_rsa creds for heroku, need
	to run:
	```
	$ ssh-add ~/.ssh/%my_other_ssh_key%
	```
	to gain access to heroku remote repository.

#####Issue checking html for title element
I was trying to test that the correct title was present in each page. For some reason or
another everybody had their own way of doing this.. I had to replace 

```
expect(response).should have_selector('title', :text => "Ruby on Rails Tutorial Sample App | Home")
```
with

```
assert_select "title", "Ruby on Rails Tutorial Sample App | About"
``` 
in my pages_controller_spec.rb file. This corrected the problem and my tests run properly now.

