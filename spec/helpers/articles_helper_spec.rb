require 'spec_helper'

# Specs in this file have access to a helper object that includes
# the ArticlesHelper. For example:
#
# describe ArticlesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       helper.concat_strings("this","that").should == "this that"
#     end
#   end
# end
describe ArticlesHelper do
  
	describe "Описание статьи" do
		it "должно содержать не более 304-х символов" do
			article = Article.new(:content => "a"*1000)
			content = description_from article.content
			content.should have_at_most(304).charachters
		end
	end

end
