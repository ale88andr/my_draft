FactoryGirl.define do

  factory :valid_user, :class => User do
    username                'user'
    password                'Pa$$w0rd'
    password_confirmation   'Pa$$w0rd'
    email                   'user@mail.com'
  end

  factory :invalid_user, parent: :valid_user do
    username nil
  end

end