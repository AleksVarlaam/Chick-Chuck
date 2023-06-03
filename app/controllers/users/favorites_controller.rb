module Users
  class FavoritesController < ApplicationController
    layout 'profile_layout'
    before_action :authenticate_user!
    before_action :set_favorite
    
    def create
      @favorite = current_user.favorites.build(favorite_params)
      
      respond_to do |format|
        if @favorite.save
          format.turbo_stream do
            flash.now[:success] = t('flash.success.created', model: @favorite.favorited_type)
          end
        else
          format.html { redirect :back, status: :unprocessable_entity }
        end
      end
    end 
    
    def destroy
      @favorite = Favorite.find(params[:id])
      respond_to do |format|
        if @favorite.destroy
          format.turbo_stream { flash.now[:success] = t('flash.success.destroyed', model: @favorite.favorited_type) }
        else
          format.html { redirect :back, status: :unprocessable_entity }
        end
      end
    end
    
    private
    
    def favorite_params
      params.require(:favorite).permit(:favorited_id, :favorited_type)
    end
    
    def set_favorite
      @favorite = Favorite.find_by(favorited_id: favorite_params[:favotired_id])
    end
  end
end