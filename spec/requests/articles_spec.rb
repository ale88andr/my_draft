require 'spec_helper'

describe "Articles" do

  before {visit articles_path}
  describe "Проверка статей" do
    it {page.should have_selector('div', :text => "К сожалению опубликованных статей пока нет!")}
  end
end
