class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!(username)
  	@user = TwitterUser.find_by(username: username)

  	@user.tweets.destroy_all
  	
  	client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = API_KEYS["consumer_key"]
		  config.consumer_secret     = API_KEYS["consumer_secret"]
		  config.access_token        = API_KEYS["access_token"]
		  config.access_token_secret = API_KEYS["access_token_secret"]
		end

  	client.user_timeline(username, count: 10).each do |x|
			@user.tweets.create!(tweet_text: x.text)
		end
  end

  def stale?
		last_updated_at = self.tweets.last.updated_at
		diff_time = Time.now - last_updated_at
		if diff_time > 900
		 true
		else
		 false
		end
	end

	def self.authenticate(username, password)
    @user = TwitterUser.find_by_username(username)

    return false if @user.nil?
	    if @user.password == password
	      return @user
	    else
	      return false
	    end
  end

  def tweet(username,text)
  	@user = TwitterUser.find_by_username(username)

  	client = Twitter::REST::Client.new do |config|
		  config.consumer_key        = API_KEYS["consumer_key"]
		  config.consumer_secret     = API_KEYS["consumer_secret"]
		  config.access_token        = @user.token
		  config.access_token_secret = @user.secret
		end

  	client.update(text)
  end

end
