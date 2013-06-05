class User < ActiveRecord::Base

  before_create :create_default_role
  before_save {email.downcase!}
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable #, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :show_email, :user_birth, :user_country, :user_sex, :user_about, :username, :role_ids

  has_many :articles
  has_many :comments

  # CanCan perms.
  has_and_belongs_to_many :roles

  # Валидации
  validates :username, uniqueness:{case_sensitive:false, message:" - В нашей базе уже есть такое имя, придумайте пожалуйсто другое!"}, presence:{message:" - Это поле должно быть заполненно!"}, length:{maximum:50, too_long:" - Слишком длинное имя, Вам следует придумать что-нибудь покороче"}
  VALID_EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, uniqueness:{case_sensitive:false, message:" - В нашей базе уже есть такой email, используйте другой электронный адрес!"}, presence:{message:" - Это поле должно быть заполненно!"}, format:{with:VALID_EMAIL_FORMAT, message:" - Это поле должно иметь следующий формат: examle@mail.com"}
  validates :password, length:{minimum:8, too_short:" - Должен состоять не менее чем из 8 символов"}, on: :create
  validates :password_confirmation, length:{minimum:8, too_short:" - Должен состоять не менее чем из 8 символов"}, on: :create

  # Scopes
  scope :named, order("username ASC")

  def role?(role)
    self.roles.find_by_name(role.to_s)
  end

  private
    def create_default_role
      self.roles << Role.find_by_name(:user)  
    end

end
