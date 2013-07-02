include ApplicationHelper

def login_admin
  before :each do
    user = User.find(1)
    user.roles << FactoryGirl.create(:role)
    sign_in user
  end
end