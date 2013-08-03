include ApplicationHelper

def login_as_user

end

def login_as_admin
  user = FactoryGirl.create(:user)
  user.roles << FactoryGirl.create(:role)
  sign_in user
end

def login_admin
  before :each do
    user = User.find(1)
    user.roles << FactoryGirl.create(:role)
    sign_in user
  end
end