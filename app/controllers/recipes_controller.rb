class RecipesController < ApplicationController
    
    def index
      @recipes = Recipe.order("total_likes DESC").paginate(page: params[:page], per_page: 4)

    end
    
    def show
      @recipe = Recipe.find_by_id(params[:id])
    end  
    
    def new
      @recipe = Recipe.new
    end
    
    def create
      @recipe = Recipe.new(recipe_params)
      @recipe.chef = Chef.find(2)
      
      if @recipe.save 
        flash[:success] = "Your recipe was created successfully!"
        redirect_to recipes_path
      else
        render :new
      end  
      
    end
    
    def edit
      @recipe = Recipe.find(params[:id])
      
    end
    
    def update 
      @recipe = Recipe.find(params[:id])
      
      if @recipe.update(recipe_params)
        flash[:success] = "Your recipe was updated!"
        redirect_to recipe_path(@recipe)
      else
        render :edit
      end 
    end
    
    def delete
      
    end  
    
    def like 
      @recipe = Recipe.find(params[:id])
      like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe )
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
    
    private 
      
      def recipe_params
          params.require(:recipe).permit(:name, :summary, :description, :picture, :total_likes)
      end  
end