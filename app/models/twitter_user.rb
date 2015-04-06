class TwitterUser < ActiveRecord::Base
  # Remember to create a migration!
  has_many :tweets

  def fetch_tweets!(username)
  	@user = TwitterUser.find_by(username: username)

  	@user.tweets.destroy_all

  	CLIENT.user_timeline(username, count: 10).each do |x|
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

end
