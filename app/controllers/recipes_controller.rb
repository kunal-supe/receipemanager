class RecipesController < ApplicationController
    before_action :set_recipe, only: [:edit, :update, :show, :like]
    before_action :require_user, except: [:index, :show]
    before_action :require_same_user, only: [:edit, :update]
    before_action :admin_user, only: :destroy
    before_action :require_same_user_review, only: :delete_review
    
    def index
      @recipes = Recipe.order("total_likes DESC").paginate(page: params[:page], per_page: 4)
    end
    
    def myrecipes
        @recipes = current_user.recipes.paginate(page: params[:page], per_page: 4)
    end
    
    def show
      @review = @recipe.reviews.new
      @reviews = Recipe.find(params[:id]).reviews.paginate(page: params[:page], per_page: 5)
    end  
    
    def new
      @recipe = Recipe.new
    end
    
    def create
      @recipe = Recipe.new(recipe_params)
      @recipe.chef = current_user
      
      if @recipe.save 
        flash[:success] = "Your recipe was created successfully!"
        redirect_to myrecipes_path
      else
        render :new
      end  
      
    end
    
    def edit

    end
    
    def update 
      if @recipe.update(recipe_params)
        flash[:success] = "Your recipe was updated!"
        redirect_to recipe_path(@recipe)
      else
        render :edit
      end 
    end
    
    def new_review
      review = Review.create(body: params[:review][:body], chef_id: params[:review][:chef_id], recipe_id: params[:review][:recipe_id])
      if review.save 
        flash[:success] = "Your review was submitted successfully!"
        redirect_to :back
      else 
        flash[:danger] = "Review must be more than 10 chars"
        redirect_to :back
      end  
    end  
    
    def delete_review
      Review.find(params[:review]).destroy
      flash[:success] = "Review Destroyed!"
      redirect_to :back
    end
    
    def delete
      
    end  
    
    def like 
      like = Like.create(like: params[:like], chef: current_user, recipe: @recipe )
      if like.valid?
        @recipe.total_likes = @recipe.likes.count
        @recipe.save
        flash[:success] = "Your selection was successful"
        redirect_to :back
      else
        flash[:danger] = "You can only like/dislike recipe once!"
        redirect_to :back
      end  
    end  
    
    
    def destroy 
      Recipe.find(params[:id]).destroy
      flash[:success] = "Recipe Destroyed!"
      redirect_to recipes_path
    end  
    
    private 
      
      def recipe_params
          params.require(:recipe).permit(:name, :summary, :description, :picture, :total_likes, style_ids: [], ingredient_ids: [])
      end  
      
      def set_recipe
        @recipe = Recipe.find(params[:id])
      end  
      
      def require_same_user
        if current_user != @recipe.chef && !current_user.admin
          flash[:danger] = "You can edit your profile only!"
          redirect_to recipes_path
        end  
      end   
      
      def require_same_user_review
        review = Review.find(params[:review])
        if current_user != review.chef && !current_user.admin
          flash[:danger] = "You can edit your profile only!"
          redirect_to :back
        end  
      end  
      
      def admin_user
        if !current_user.admin?
          flash[:danger] = "You require admin rights for this action"
          redirect_to recipes_path
        end  
      end  

end