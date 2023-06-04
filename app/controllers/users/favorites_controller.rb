module Users
  class FavoritesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_user!
    
    def index
      @favorite_items = current_user.favorites
    end
    
    def create
      @favorite = current_user.favorites.build(favorite_params)
      
      respond_to do |format|
        if @favorite.save
          format.turbo_stream do
            flash.now[:success] = t('flash.success.saved', model: @favorite.favorited.title)
          end
        else
          format.html { redirect :back, status: :unprocessable_entity }
        end
      end
    end 
    
    def destroy
      @favorite = Favorite.find(params[:id])
      @object = @favorite.favorited
      
      respond_to do |format|
        if @favorite.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @favorite.favorited.title) }
        else
          format.html { redirect :back, status: :unprocessable_entity }
        end
      end
    end
    
    private
    
    def favorite_params
      params.require(:favorite).permit(:favorited_id, :favorited_type)
    end
  end
end