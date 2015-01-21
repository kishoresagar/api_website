class Tweet < ActiveRecord::Base
	include ActiveModel::MassAssignmentSecurity

  belongs_to :user

  def self.add_tweets(user)
  	twitter = Twitter::REST::Client.new do |config|
		  config.consumer_key        = AppConfig['twitter']['consumer_key']
		  config.consumer_secret     = AppConfig['twitter']['consumer_secret']
		  config.access_token        = user.tw_token
		end
		tweets = twitter.user_timeline(user.username, {count: 10})
		tweets.each do |t|
			tweet = user.tweets.new
			tweet.username = t.user.screen_name
			tweet.text = t.text
			tweet.save
		end
  end
end
