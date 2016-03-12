class ReviewsController < ApplicationController
  #before_action :require_user, except: [:show]
  #before_action :require_same_user, only: [:edit, :update]
  #before_action :admin_user, only: [:destroy]
  
  #def index
   # @reviews = Review.paginate(page: params[:page], per_page: 4)
  #end
  
  #def show

  #end
  
  #def new
   # @review = Review.new
  #end
  
  def create
    @recipe = Recipe.find(params[:recipe_id])
    @review = @recipe.reviews.build(review_params)
    @review.chef = current_user
    
    if @review.save
      flash[:success] = "Your review was written successfully!"
      redirect_to :back
    else
      render :new
    end
  end
  
  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.find(params[:id])
  end
  
  def update
    @recipe = Recipe.find(params[:recipe_id])
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[:success] = "Your recipe was updated successfully!"
      redirect_to chef_path(current_user)
    else
      render :edit
    end
  end
    
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review deleted"
    redirect_to recipes_path(@recipe)
  end
  
  private
    
    def review_params
      params.require(:review).permit(:review)
    end
  
    def set_review
      @review = Review.find(params[:id])
    end
  
    def require_same_user
      if current_user != @review.chef and !current_user.admin?
        flash[:danger] = "You can only edit your own reviews"
        redirect_to :back
      end
    end
    
    def admin_user
      redirect_to :back unless current_user.admin?
    end
    
end
