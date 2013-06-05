require 'spec_helper'

describe "Static pages" do

  # выполнится перед каждым следующим тестом
  before {visit root_path}
  # по умолчанию объекотом назначается page
  subject {page}

  describe "Home page" do
    it {should have_selector('h1', :text => "My Draft")}
    it {should have_selector('a', :text => "My Draft")}
    it {should have_selector('title', :text => full_title("Home"))}
  end
  
end
