class OrdersController < ApplicationController

  def index
    @orders = Dish.get_orders
  end

end
