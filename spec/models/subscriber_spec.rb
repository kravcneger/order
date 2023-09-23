require 'rails_helper'

RSpec.describe 'Subscriber', type: :model do
  subject{ Subscriber.new(email: "email@email.com")}
  before{ subject.save }
  
  it "invalid emal" do
    subject.email = "1"
    expect { subject.save! }.to raise_error ActiveRecord::RecordInvalid
  end
  
  it "email is not uniq" do
    subscriber = Subscriber.new(email: "email@email.com")
    expect { subscriber.save! }.to raise_error ActiveRecord::RecordInvalid
  end

  it "exclusion relation" do
    salt = Ingredient.new(name: "salt")
    subject.excluded_ingredients << salt
    expect { subject.save! }.not_to raise_error
		expect(subject.excluded_ingredients.reload.count).to eq(1)
    expect(Ingredient.all.count).to eq(1)
  end

  it "success" do
    expect(Subscriber.all.count).to eq(1)
  end
end