
require 'sinatra'
require 'pg'
require 'active_record'
require_relative 'database_config'
require_relative 'models/goal'
require_relative 'models/user'
require_relative 'models/comment'


enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user
  end
end

after do
 ActiveRecord::Base.connection.close
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect '/'
  else
    @error_message = 'invalid email/password combo'
    erb :login
  end
end


delete '/session' do
  session[:user_id] = nil
  redirect '/'
end

get '/' do
  @goals = Goal.all

  erb :index
end

get '/about' do
  erb :about
end

get '/login' do
  erb :login
end

get '/goal/new' do
  erb :new
end

post '/setgoal' do
 newGoal = Goal.new
 newGoal.image_url = params[:img_url]
 newGoal.ambition = params[:newGoal]
 newGoal.user_id = User.find_by(id: session[:user_id]).id
 newGoal.duedate = params[:due_date]
 if newGoal.save
   redirect '/'
 else
   erb :new
 end
end

get '/:email/profile' do
  @goals = Goal.all
  erb :profile
end

post '/createuser' do
  newUser = User.new
  newUser.email = params[:email]
  newUser.password = params[:password]
  newUser.username = params[:username]
  if newUser.save
    session[:user_id] = newUser.id
    redirect '/'
  else
    erb :index
  end
end

post '/comments' do
  newComment = Comment.new
  newComment.body = params[:commentBody]
  newComment.goal_id = params[:goal_id]
  newComment.user_id = current_user.id
  if newComment.save
    redirect '/'
  else
    erb :index
  end
end

post '/deletegoal' do
  g = Goal.find(params[:goal_id])
  g.destroy
  redirect '/'
end

post '/completegoal' do
  completeGoal = Goal.find(params[:goal_id])
  completeGoal.status = true
  completeGoal.save
  redirect '/'
end
