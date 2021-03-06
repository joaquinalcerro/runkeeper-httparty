# runkeeper-httpary

So you want to access the Runkeeper’s API with HTTParty Gem. Well, this article is for you.

This is how I did it. Hope it helps you.

1. Register you web application and get your Client ID and Secret form Runkeeper’s Partner Portal Web Site

https://runkeeper.com/partner

2. Generate your access token

To generate your access token, you have to run the following command in terminal window:
a. gem install launchy rack
b. Run bundle install
b. CLIENT_ID=“your Client ID” CLIENT_SECRET=“your Client Secret”
AUTHORIZATION_URL=“https://runkeeper.com/apps/authorize”
ACCESS_TOKEN_URL=“https://runkeeper.com/apps/token” token_generator

—- note: this is a one line command —-

c. The command will open a browser window with Runkeeper’s website login
d. Return to your terminal windows and your token will be displayed if your login was successful

Check this website where I found the procedure: http://www.vinnycoyne.com/post/56247548995/send-jawbone-up-sleep-data-to-runkeeper

3. Add following line to add HTTParty gem in your Gemfile

gem ‘httparty’

From a terminal windows run the command: bundle install
This will install latest version of HTTParty Gem

4. I recommend you to check the following site for further information on HTTParty and Runkeeper’s API example calls

a. http://www.rubydoc.info/github/jnunemaker/httparty/HTTParty/ClassMethods
b. https://runkeeper.com/developer/healthgraph/example-api-calls#top

5. Modify your routes. Add a activity resource for this example. You can modify to suite your needs.

resources :activities

6. Create your controller with the following code:

class ActivitiesController < ApplicationController

def index
  @user = Activity.grab_user
  @activities = Activity.grab_activities
end

end

7. Create a environment variable with your token code

Add the following to your .bash_profile

export RUN_KEEPER_TOKEN=”xxxxxxxxxxxxxxxxxxxxxxxx”

replace “xxxxxxxxxxxxxxxxxxxxxxxx” with your token code

8. Create your model with the following code:

class Activity
	include HTTParty

	hostport = “api.runkeeper.com”
	base_uri “http://#{hostport}”
	format :json

	def self.grab_user
		headers ‘Authorization’ => ‘Bearer ENV[“RUN_KEEPER_TOKEN”]’, ‘Accept’ =>     “application/vnd.com.runkeeper.User+json”
		get(“/user”)
	end

	def self.grab_activities
		headers ‘Authorization’ => ‘Bearer ENV[“RUN_KEEPER_TOKEN”]’, ‘Accept’ =>      “application/vnd.com.runkeeper.FitnessActivityFeed+json”
		get(“/fitnessActivities”)[“items”]
	end
end

9. Create your view file 

Enjoy!!

Keep in mind that for the HTTParty to work properly you have to change the headers depending on the resource you are accessing.

Please leave your comments.