class StocksController < ApplicationController
    
    def search
        if params[:stock].blank?
            flash[:danger] = "You have entered an incorrect string"
        else
            @stock = Stock.new_from_lookup(params[:stock])
            flash[:danger] = "Sorry that symbol doesn't exist" unless
            @stock
        end
        respond_to do |format|
            format.js{render partial: 'users/results'}
        end
    end
    
end