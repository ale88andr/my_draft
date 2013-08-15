require 'spec_helper'

describe Tag do

	subject { Tag.new }

	it { should respond_to :name }
	it { expect(Tag.superclass).to eq(ActiveRecord::Base) }

	describe "association" do
		it "with article" do
			assoc = User.reflect_on_association(:articles)
			assoc.macro.should == :has_many
		end
	end# association

	describe "validation" do
		it "with invalid data" do
			expect(Tag.new(name:nil)).not_to be_valid
		end

		it "with valid data" do
			expect(Tag.new(name:"Tag")).to be_valid
		end
	end# validation

end