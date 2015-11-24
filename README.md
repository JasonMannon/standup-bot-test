## Standup-Bot

===
####Automated Standups for Slack Private Groups
Messaging tools like Slack changed our work world. Standup changed our meetings. Standup Bot keeps us accountable, tracks our goals, and got us to post our successes, plans, and upcoming challenges. We love it so much and we think you will too, so we're releasing it Open-Source.

#### Local Setup:
  * Clone repository `git clone git@github.com:sofetch/slack-standup-bot.git`
  * Create and migrate DB.  `rake db:create` `rake db:migrate`
  * Add a .env file to slack-standup-bot directory
  * Add a bot integration in slack `https://your-team.slack.com/services/new/bot`
  * Copy your API code to the .env file.  `SLACK_API_TOKEN=your-token`
  * Add your bot to the private slack group you want to use the bot with.
  * Start a local server and visit `http://localhost:3000/settings`  Enter your private group name and bot name and save.
  * Visit `http://localhost:3000/api/start` to begin your standup.
  * Visiting `http://localhost:3000/settings` will allow you to edit your group and bot name.


#### Heroku Setup (After local is setup):
  * Create a heroku app and push the standup-bot directory to Heroku.
  * Migrate DB `heroku run rake db:migrate`
  * visit `http://your-app.herokuapp.com/settings` and fill in your bot name and private group name
  * Add a slash command integration. `https://your-team.slack.com/services/new/slash-commands`. This command is going to start your daily standup.  Enter `/standup` as the command and `http://your-app.herokuapp.com/api/start` as the url.  Set the method to GET.
  * Typing /standup will launch a standup.


#### Commands:
  * `-start` Begins standup.
  * `-skip`  Skips your turn until the end of standup.
  * `-yes`   Agrees to start your standup.
  * `-help`  Displays standup-bot commands in your group.
  * `-edit: #(1,2,3)` Edit your answer for the day.
  * `-delete: #(1,2,3)` Delete your answer for the day.
  * `-vacation: @user`  Skip users standup for the day.
  * `-skip: @user`  Place user at the end of standup.
  * `-n/a: @user`   Skips users standup for the day
  * `-quit-standup` Quit standup.


##### How to make a pull request:

1. Fork it ( https://github.com/sofetch/slack-standup-bot/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
