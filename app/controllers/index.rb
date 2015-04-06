get '/' do
  erb :index
end

post '/create' do
	@user = TwitterUser.find_or_create_by(username: params[:user][:username])

	if (@user.tweets.empty? || @user.stale?)
		@user.fetch_tweets!(@user.username)
		
	end
	return @user.username
end

get '/:username' do |username|
	@user = TwitterUser.find_by_username(username)
		   
	@tweets = @user.tweets
	erb :display
end
