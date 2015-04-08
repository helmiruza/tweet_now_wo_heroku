class TweetWorker < ActiveRecord::Base
  # Remember to create a migration!
  include Sidekiq::Worker

  def perform(username,text)
    @user = TwitterUser.find_by_username(username)

    client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = ENV["consumer_key"]
		  config.consumer_secret     = ENV["consumer_secret"]
		  config.access_token        = @user.token
		  config.access_token_secret = @user.secret
		end

		client.update(text)
	end
	
end