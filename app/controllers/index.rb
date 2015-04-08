enable :sessions

get '/' do
	if session[:username] != nil
		@user = TwitterUser.find_by(username: session[:username]) 
		redirect to "/dashboard/#{@user.username}"
	else
		erb :index
	end
end

get 'recent' do
	erb:recent
end

post '/create' do

	@user = TwitterUser.find_or_create_by(username: params[:other][:username])
	
	if (@user.tweets.empty? || @user.stale?)
		@user.fetch_tweets!(@user.username)
		
	end
	return @user.username
end

get '/get/:username' do |username|
	if session[:username] != nil
		@user = TwitterUser.find_by_username(username)
			   
		@tweets = @user.tweets
		erb :display

	else
		redirect to "/"
	end
end

post '/send/tweet' do
	@user = TwitterUser.find_by_username(session[:username])
	@user.tweet(@user.username, params[:tweetnow][:text])

end
