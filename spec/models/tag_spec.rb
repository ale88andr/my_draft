require 'spec_helper'

describe Tag do
  
	let!(:tag) {Tag.new}

	subject{tag}

	it {should respond_to :name}

	it "model inheritance from ActiveRecord" do
		expect(Tag.superclass).to eq(ActiveRecord::Base)
	end

	it "responds to name" do
		tag.name = "new_tag_name"
		expect(tag.name).to eq("new_tag_name")
	end

	describe "association" do

		it "should associate with article model" do
			assoc = User.reflect_on_association(:articles)
			assoc.macro.should == :has_many
		end
		
	end	

	describe "validation tags" do

		it "with invalid data" do
			tag = Tag.new(name:nil)
			expect(tag).not_to be_valid
		end

	end

end