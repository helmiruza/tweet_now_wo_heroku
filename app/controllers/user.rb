enable :sessions

get '/dashboard/:username' do |username|
	erb :dashboard
end

get '/auth/twitter/callback' do

@user = TwitterUser.find_or_create_by(username: env['omniauth.auth']['info']['nickname']) 

session[:username] = @user.username
@user.token = env['omniauth.auth']['credentials']['token']
@user.secret = env['omniauth.auth']['credentials']['secret']
@user.save

redirect to "/dashboard/#{@user.username}"
end

get '/auth/failure' do
  params[:message]
end

get '/logout' do
	session.clear
	redirect to "/"
end