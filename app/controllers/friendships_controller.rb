class FriendshipsController < ApplicationController
    
    def destroy
        @friendship = current_user.friendship.where(friend_id: params[:id]).first
        @friendship.destroy
        flash[:notice] = "Friend was removed"
        redirect_to my_friends_url
    end
    
end
