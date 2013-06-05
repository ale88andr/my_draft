require 'spec_helper'

describe Article do
  before {@article = Article.new(title:"Title 1", content:"Title 1 content", category_id:1)}
  subject {@article}

  it {should respond_to :title}
  it {should respond_to :content}
  it {should respond_to :category_id}
end
