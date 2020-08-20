class CategoriesController < ApplicationController
  def index
    @category = Category.all
    if @category.empty?
      render :json => {
          :error => "We have no information at the moment"
      }
    else
      render :json =>{
          :response => "We are in business",
          :data  =>  @category
      }
    end
  end

  def create
    @new_category = Category.new(category_params)
    if @new_category.save
      render :json => {
          :response => "Success",
          :data => @new_category
      }
    else
      render :json => {
          :error => "Cannot be saved. Check fields"
      }
    end
  end

  def show
    @single_category = Category.exists?(params[:id])
    if @single_category
      render :json => {
          :response => "Record has been found",
          :data => Category.find(params[:id])
      }
    else
      render :json => {
          :error => "Record not found"
      }
    end
  end

  def update

    if (@single_category_update = Category.find_by_id(params[:id])).present?
      @single_category_update.update(category_params)
      render :json => {
          :response => "update succesful",
          :data => @single_category_update
      }
    else
      render :json => {
          :error => "cannot update selected record. Check if it exists"
      }
    end
  end

  def destroy

    if (@single_category_delete = Category.find_by_id(params[:id])).present?
      @single_category_delete.destroy
      render :json => {
          :response => "Successfully Deleted"
      }
    else
      render :json => {
          :error => "No file to delete"
      }
    end
  end


  private
  def category_params
    params.permit(:id, :title, :description, :created_by)
  end
end
