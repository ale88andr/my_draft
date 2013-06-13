require 'spec_helper'

describe UsersController do

  let(:user) {mock_model("User").as_new_record}

  before :each do
    User.stub(:new).and_return(user)
  end

end
