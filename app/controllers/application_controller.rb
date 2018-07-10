require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "cookbook365_secret", "password_security"
  end

  get '/' do
    if logged_in?
      redirect "/account/#{session[:user_id]}"
    else
      erb :index, :layout => :"layout_index"
    end
  end

 helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end

  end
end
