class UsersController < ApplicationController

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      redirect '/account'
    else
      redirect '/login'
    end
  end

  get '/signup' do
    erb :"users/signup"
  end

  post '/signup' do
    if !params.values.include? ""
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/account'
    else
      redirect '/signup'
    end
  end

  get '/account' do
    erb :"users/account"
  end


end
