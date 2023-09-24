class DishesController < ApplicationController

  def index
    @dishes = Dish.all.includes(:ingredients)
  end

end
