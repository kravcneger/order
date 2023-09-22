require 'rails_helper'

RSpec.describe 'Ingredient', type: :model do
  subject{ Ingredient.new(name: "salt")}
  before{ subject.save }
  
  it "name length is too short" do
    subject.name = "1"
    expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid
  end
  
  it "name is not uniq" do
    ingredient2 = Ingredient.new(name: "salt")
    expect { ingredient2.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it "relations dishes" do
    dish = Dish.new(name: "borsch")
    dish.ingredients << subject
    expect { dish.save! }.not_to raise_error 
    expect(Ingredient.all.count).to eq(1)
  end

  it "success" do
    expect(Ingredient.all.count).to eq(1)
  end
end