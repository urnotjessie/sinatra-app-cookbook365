require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    register Sinatra::Flash
    set :session_secret, "cookbook365_secret"

  end

  get '/' do
    if logged_in?
      @user = User.find(session[:user_id])
      redirect "/account/#{@user.slug}"
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
