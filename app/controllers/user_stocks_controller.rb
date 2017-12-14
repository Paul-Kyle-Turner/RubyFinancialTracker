class UserStocksController < ApplicationController
    
    def create
        stock = Stock.find_by_ticker(params[:stock_ticker])
        if stock.blank?
            stock = Stock.new_from_lookup(params[:stock_ticker])
            stock.save
        end
        @user_stocks = UserStock.create(user: current_user, stock: stock)
        flash[:success] = "Stock #{@user_stocks.stock.name} was added to your portfolio"
        redirect_to my_portfolio_url
    end
    
    def destroy
        stock = Stock.find(params[:id])
        @user_stock = UserStock.where(user_id:current_user.id, stock_id:stock.id).first
        @user_stock.destroy
        flash[:notice] = "Stock was successfully removes from portfolio"
        redirect_to my_portfolio_url
    end
    
end
