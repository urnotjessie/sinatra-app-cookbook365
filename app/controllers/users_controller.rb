class UsersController < ApplicationController

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/recipes'
    else
      redirect '/'
    end
  end

  get '/signup' do
    erb :"users/signup"
  end

  post '/signup' do
    if !params.values.include? "" && !User.find_by(username: params[:username])
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/recipes'
    else
      redirect '/signup'
    end
  end

  get '/account/:id' do
    if current_user && logged_in?
      @user = User.find(params[:id])
      erb :"users/account"
    else
      redirect '/'
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/'
    else
      redirect '/'
    end
  end


end
