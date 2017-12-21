class UsersController < ApplicationController
    def my_portfolio
        @user = current_user
        @user_stocks = current_user.stocks
    end
    
    def my_friends
        @friendships = current_user.friends
    end
    
    def search
        if params[:search_param].blank?
            flash.now[:danger] = "You have entered an empty string"
        else
            @users = User.search(params[:search_param])
            @users = User.except_current_user(@users)
            flash.now[:danger] = "No users match" if @users.blank?
        end
        respond_to do |format|
            format.js {render partial: 'friends/result'}
        end
    end
    
    def not_friends_with?(friend_id)
        friendships.where(friend_id: friend_id).count < 1
    end
    
    def add_friend
        @friend = User.find(params[:friend])
        current_user.friendships.build(friend_id: @friend.id)
        
        if current_user.save
            flash[:success] = "Added Friend"
        else
            flash[:danger] = "Something went wrong"
        end
        redirect_to my_friends_url
    end
    
    def show
        @user = User.find(params[:id])
        @user_stocks = @user.stocks
    end
end