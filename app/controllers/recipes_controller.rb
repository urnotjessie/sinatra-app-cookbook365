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

      redirect "/account/#{@user.slug}"

    else
      flash[:message] = "Please add recipe name!"
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

    if current_user.recipes.include?(@recipe) && params[:recipe_name] != ""
      @recipe.update(
        recipe_name: params[:recipe_name],
        serving_size: params[:serving_size],
        cook_time: params[:cook_time],
        ingredients: params[:ingredients],
        method: params[:method] )

      redirect "/account/#{current_user.slug}"

    elsif params[:recipe_name] == ""
      flash[:message] = "Please add recipe name!"
      redirect "/edit/#{@recipe.id}"

    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

  delete '/delete/:id' do

    @recipe = Recipe.find(params[:id])
    if current_user.recipes.include?(@recipe)
      @recipe.delete

      redirect "/account/#{current_user.slug}"
    else
      redirect "/recipes/#{@recipe.id}"
    end
  end

end
