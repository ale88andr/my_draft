require 'spec_helper'

describe Category do

  let!(:category) { Category.new }
  subject {category}

  it { should respond_to :name }
  it { should respond_to :description }

  it { Category.superclass.should eq(ActiveRecord::Base) }

  describe "associations" do

    it "should associated with articles" do
      assoc = Category.reflect_on_association(:articles)
      assoc.macro.should == :has_many
    end

  end

  describe "validation model" do

    before :each do
      @params = {
        name:         "new category_name",
        description:  "new category_description"
      }
    end

    context "with invalid values" do
      it "adding category with empty name" do
        @params[:name] = nil
        category = Category.new(@params)
        expect(category).not_to be_valid
      end
      it "adding too long name category" do
        @params[:name] = 'z' * 500
        category = Category.new(@params)
        expect(category).not_to be_valid
      end
    end

    context "with valid values" do
      it "adding category with valid data" do
        category = Category.new(@params)
        expect(category).to be_valid
      end
    end

  end

end
