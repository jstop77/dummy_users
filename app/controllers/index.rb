get '/' do
  # Look in app/views/index.erb
  erb :index
end

post '/users' do
    @user=User.new(email: params[:email], password: params[:password])
    @user.save
    erb :registered
end

# get '/login' do
#   if session[:email] == params[:email]
#     redirect '/secret_page'
#   else
#     redirect erb '/index'
#   end

get '/login' do

  if User.authenticate(params[:email], params[:password]).present?

    user = User.find_by(email: params[:email])
    session[:id] = user.id

    redirect to('/secret_page')

  else

    redirect to('/')
  end

end

get '/secret_page' do
  if session[:id] != nil
    # "session_id = " << session[:session_id]
    @user = User.find(session[:id])
    erb :secret_page
  else
    redirect to('/')
  end
end



get '/logout' do
  session.clear
  redirect to('/')
end