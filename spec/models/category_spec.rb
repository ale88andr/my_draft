require 'spec_helper'

describe Category do
  before {@category = Category.new(name:"Category 1", description:"Description for Category 1")}
  subject {@category}

  it {should respond_to :name}
  it {should respond_to :description}
  it {should be_valid}

  describe "Название категории не заполненно" do
  	before {@category.name = ""}
  	it {should_not be_valid}
  end

  describe "Превышение длинны названия категории" do
  	before {@category.name = "x"*256}
  	it {should_not be_valid}
  end

end
