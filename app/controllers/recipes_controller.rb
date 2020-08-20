class RecipesController < ApplicationController
  before_action :authorized

  def index
    @recipe = Recipe.where({ category_id: params[:category_id] })
    if !@recipe.exists?
      render json: {
          "error": "Oops, there is no data to show"
      }
    else
      render json: {
          "reponse": "This is working",
          :data => @recipe
      }
    end
  end

  def create
    @new_recipe = Recipe.new(recipe_params)
    if Category.exists?(@new_recipe.category_id)
      if @new_recipe.save
        render :json => {
            :response => "successfully created",
            :data => @new_recipe
        }
      else
        render :json => {
            :response => "oops something went wrong"
        }
      end
    else
      render :json => {
          :error => 'Category does not exists'
      }
    end
  end

  def show
    @single_recipe = Recipe.exists?(params[:id])
    if @single_recipe
      render :json => {
          :response => {
              :response => "success",
              :data => Recipe.find(params[:id])
          }
      }
    else
      render :json => {
          :response => "record not found"
      }
    end
  end

  def update
    if(@recipe_update = Recipe.find_by_id(params[:id])).present?
      @recipe_update.update(recipe_params)
      render :json => {
          :response => "successful update",
          :data => @recipe_update
      }
    else
      render :json => {
          :response => "cannot update selected record."
      }
    end
  end

  def destroy
    if(@delete_recipe = Recipe.find_by_id(params[:id])).present?
      @delete_recipe.destroy
      render :json => {
          :response => 'Successfully Deleted'
      }
    else
      render :json => {
          :response => "No file to delete"
      }
    end
  end



  private
  def recipe_params
    params.permit(:id, :name, :ingredient, :directions, :notes, :tags, :category_id)
  end

end
