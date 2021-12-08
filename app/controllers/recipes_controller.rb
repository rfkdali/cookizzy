class RecipesController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_recipe, only: %i[ show edit update destroy ]

  def index
    @recipes = search_recipes

    respond_to do |format|
      format.html { render :index, status: :ok }
      format.json { render json: { recipes: @recipes }, status: :ok }
    end
  end

  def search
    @recipes = search_recipes

    render json: { recipes: @recipes }, status: :ok
  end

  def show
    respond_to do |format|
      format.html { render :show, status: :ok }
      format.json { render json: @recipe, status: :ok }
    end
  end

  def new
    @recipe = Recipe.new
  end

  def edit
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: "Recipe was successfully created." }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Recipe was successfully updated." }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url, notice: "Recipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def search_recipes
    params[:name] ? Recipe.search_by_ingredients(params[:name]) : Recipe.all
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name)
  end
end
