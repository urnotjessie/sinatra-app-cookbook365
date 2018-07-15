class UsersController < ApplicationController

  post '/login' do
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/recipes'
    else
      flash[:message] = "Wrong email or password!"
      redirect '/'
    end
  end

  get '/signup' do
    erb :"users/signup", :layout => :"layout_index"
  end

  post '/signup' do
    if !params.values.include?("") && !User.find_by(email: params[:email])
      @user = User.create(username: params[:username], email: params[:email], password: params[:password])
      session[:user_id] = @user.id
      redirect '/recipes'
    elsif User.find_by(email: params[:email])
      flash[:message] = "User already registed, please log in!"
      redirect '/'
    elsif params.values.include?("")
      flash[:message] = "Please complete the form to signup!"
      redirect '/signup'
    end
  end

  get '/account/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :"users/account"
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
