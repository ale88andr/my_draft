class StaticPagesController < ApplicationController
  def home
    @presenter = Home::IndexPresenter.new()
  end

  def help
  end

  def about
  end
end
