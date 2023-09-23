require 'rails_helper'

Rails.application.load_tasks

RSpec.describe 'Dish', type: :model do
  subject{ Dish.new(name: "borsch")}
  before{ subject.save }
  
  it "name length is too short" do
    subject.name = "1"
    expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid
  end
  
  it "name is not uniq" do
    dish2 = Dish.new(name: "borsch")
    expect { dish2.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it "relations ingedients" do
    salt = Ingredient.new(name: "salt")
    salt.dishes << subject
    expect { salt.save! }.not_to raise_error 
    expect(Dish.all.count).to eq(1)
  end

  it "success" do
    expect(Dish.all.count).to eq(1)
  end

  describe "#get_orders" do
    let(:expect_res){Dish.get_orders}
    let(:eq_res){ [{"count"=>4, "id"=>1, "name"=>"борщ"}, 
      {"count"=>4, "id"=>3, "name"=>"мастава"}, 
      {"count"=>4, "id"=>2, "name"=>"плов"}, 
      {"count"=>3, "id"=>4, "name"=>"роллы"}]}
    before do
      Rake::Task["db:seed"].invoke
    end
    it { expect(expect_res).to eq(eq_res) }
  end
end