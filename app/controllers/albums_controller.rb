class AlbumsController < ApplicationController
    def create 
        @album = Album.new(album_params)
        if @album.save
            redirect_to album_url(@album)
        else
            flash.now[:errors] = @album.errors.full_messages
        end 
    end 

    def show
        @album = Album.find(params[:id])
        render :show
    end 

    def edit
        @album = Album.find(params[:id])
        render :edit
    end 
    
    def update
        @album = Album.find(params[:id])
        render :update
    end 

    def destroy 
        @album = Album.find(params[:id])
        @album.destroy
        redirect_to albums_url
    end 

    def album_params
        params.require(:album).permit(:title, :year, :band_id, :live)
    end 

    def new
        render :new
    end 
end
