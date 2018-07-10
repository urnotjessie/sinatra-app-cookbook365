class RecipesController < ApplicationController

  get '/new' do
    if logged_in?
      erb :"recipes/new"
    else
      redirect '/'
    end
  end


  post '/recipes/new' do
    @user = User.find(session[:user_id])

    if params[:recipe_name] != ""

      @recipe = Recipe.create(
        recipe_name: params[:recipe_name],
        serving_size: params[:serving_size],
        cook_time: params[:cook_time],
        ingredients: params[:ingredients],
        method: params[:method])
      @user.recipes << @recipe
      @user.save

      redirect "/account/#{@user.id}"

    else
      redirect '/new'
    end

  end

  get '/recipes' do
    erb :"recipes/collection"
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :"recipes/show"
  end

  get '/edit/:id' do

    @recipe = Recipe.find(params[:id])
    erb :"recipes/edit"
  end

  patch '/edit/:id' do
    @recipe = Recipe.find(params[:id])

    @recipe.update(
      recipe_name: params[:recipe_name],
      serving_size: params[:serving_size],
      cook_time: params[:cook_time],
      ingredients: params[:ingredients],
      method: params[:method] )

    redirect "/account/#{@recipe.user_id}"
  end

  delete '/delete/:id' do

    @recipe = Recipe.find(params[:id])
    @recipe.delete

    # flash[:message] = "recipe has been deleted successfully"

    redirect "/account/#{@recipe.user_id}"
  end



end
