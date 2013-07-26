require 'spec_helper'

describe ArticlesHelper do
  
	describe "Описание статьи" do
		it "должно содержать не более 304-х символов" do
			article = Article.new(:content => "a"*1000)
			content = description_from article.content
			content.should have_at_most(304).charachters
		end
	end

end
