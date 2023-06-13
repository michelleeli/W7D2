class UsersController < ApplicationController
    def new
        @user = User.new
        render :new
    end 

    def create 
        @user = User.new(params.require(:user).permit(:email, :password))
        if @user.save
            redirect_to user_url(@user)
            login(@user) 
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end 
    end 

    def show
        @user = User.find(params[:id])
        render :show
    end 
end
