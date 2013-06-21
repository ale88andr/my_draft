require 'spec_helper'

describe UsersController do

  let(:user) { mock_model("User").as_null_object }

  before :each do
    User.stub(:new).and_return(user)
  end

end
