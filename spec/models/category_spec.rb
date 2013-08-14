#encoding: utf-8
require 'spec_helper'

describe Category do

  subject { Category.new }

  it { should respond_to :name }
  it { should respond_to :description }

  it { Category.superclass.should eq(ActiveRecord::Base) }

  describe "associations" do

    it "with articles" do
      assoc = Category.reflect_on_association(:articles)
      assoc.macro.should == :has_many
    end

  end

  describe "validation model" do

    context "invalid values" do
      it "with empty name" do
        FactoryGirl.build(:category, name: nil).should_not be_valid
      end
      it "with long name" do
        FactoryGirl.build(:category, name: "z" * 256).should_not be_valid
      end
    end

    context "valid values" do
      it "with valid data" do
        FactoryGirl.build(:category).should be_valid
      end
    end

  end

  describe "scopes" do

    context "default scope" do

      before :each do
        @cat1 = FactoryGirl.create(:category, name: "Bored")
        @cat2 = FactoryGirl.create(:category, name: "Course")
        @cat3 = FactoryGirl.create(:category, name: "Armed")
      end

      subject { Category.all }

      it "with order by name" do
        should == [@cat_3, @cat_1, @cat_2]
      end

    end

  end

end
