class SubscribersController < ApplicationController
  around_action :wrap_in_transaction, only: :sign_in

  def sign_in
    subscriber = Subscriber.create!(subscribe_params)
    
    (exclude_params[:ingredient_ids] || []).each do |ing|
      subscriber.exclusions << subscriber.exclusions.new(ingredient_id: ing)
    end
    flash.discard(:error)
    subscriber.save!

    redirect_to subscribers_index_path
  end

  def index
    @ingredients = Ingredient.all
  end

  private
  def subscribe_params
    params.require(:subscriber).permit(:email)
  end

  def exclude_params
    params.require(:subscriber).permit(ingredient_ids: [])
  end

  private

  def wrap_in_transaction
    ActiveRecord::Base.transaction do
      begin
        yield
      rescue ActiveRecord::RecordInvalid => exception
        flash[:error] = exception
        redirect_to subscribers_index_path
      end
    end
  end
end
