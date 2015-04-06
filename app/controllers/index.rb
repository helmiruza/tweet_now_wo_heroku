require 'twitter'

get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/create' do
	@user = TwitterUser.find_by_username(params[:user][:username])

	if @user.nil?
		@user = TwitterUser.create(username: params[:user][:username])
	end

	redirect to "/#{@user.username}"
end

get '/:username' do |username|
	@user = TwitterUser.find_by_username(username)
	
	if (@user.tweets.empty? || @user.stale?)
		@user.fetch_tweets!(username)
	end
		   
	@tweets = @user.tweets
	erb :display
end
