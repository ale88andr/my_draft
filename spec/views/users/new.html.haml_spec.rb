require 'spec_helper'

describe "devise/registrations/new.html.erb" do

  before(:each) do
  	render
  end

  def is_form_element(selector)
  	expect(rendered).should have_selector(selector)
  end

  it "Присутствие в шаблоне формы new_user" do
  	is_form_element('form#new_user')
  end
  it "Присутствие в форме регистрации поля для ввода имя пользователя" do
  	is_form_element('#user_username')
  end
  it "Присутствие в форме регистрации поля для ввода email пользователя" do
  	is_form_element('#user_email')
  end
  it "Присутствие в форме регистрации поля для ввода пароля" do
  	is_form_element('#user_password')
  end
  it "Присутствие в форме регистрации поля для повторного ввода пароля" do
  	is_form_element('#user_password_confirmation')
  end
  it "Присутствие в форме регистрации кнопки 'Присоединиться'" do
  	expect(rendered).should have_button("Присоединиться")
  end
end