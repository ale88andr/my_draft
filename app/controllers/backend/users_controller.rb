class Backend::UsersController < Backend::ApplicationController

  def index
    @users = User.named
  end

  def show
    getUserByIdFromGet
  end

  def update
    getUserByIdFromGet
    if @user.update_attributes(params[:user])
      redirect_to backend_users_path, notice: "Сведения о пользователе '#{@user.username}' обновленны."
    else
      flash[:error] = "Сведения о пользователе не обновленны."
      render "edit"
    end
  end

  def edit
    getUserByIdFromGet
  end

  def destroy
    getUserByIdFromGet.destroy
    redirect_to backend_users_path, notice: 'Пользователь удалён!'
  end

  protected

    def getUserByIdFromGet
      @user = User.find(params[:id])
    end

end
