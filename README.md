
#initialize new application without default tests
rails new sample_app -T

# configure Gemfile for heroku deployment:

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

Also, add the file public/index.html as there is no root production route set by default by the 'rails new' command. It will work on your local system but not on heroku.

Once all of this is done, init a git repository and commmit

Then:
$ rake db:migrate

To run development:
$ rails s

open browser to localhost

To run production:

$ heroku create
$ git push heroku master

once this is finished:

$ heroku open 

or copy the given url into the browser. Should see contents of index.html page that was created in /public. 

after this run:
$ heroku run rake db:setup
$ heroku rake db:migrate

Start developing your models and shit.