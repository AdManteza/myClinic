class Admin::UsersController < Admin::AdminController
  before_action :user, only: %i[show edit update destroy]
  before_action :users, only: %i[index]
  before_action :setup_user, only: %i[create]

  def index
    respond_to do |format|
      format.html { @users }
      format.json { render json: @users }
    end
  end

  def create
    respond_to do |format|
      if @user.save
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html {}
      format.json { head :no_content }
    end
  end

  private

  def user
    @user ||= current_site.users.where(id: params[:id]).first
  end

  def users
    @users ||= current_site.users.page(params[:page])
  end

  def setup_user
    @user          = current_site.users.build(user_params)
    @user.password = PasswordStrategy.random if user_params[:password].blank?
  end

  def user_params
    params.fetch(:user).permit(
      :username,
      :firstname,
      :lastname,
      :password,
      :contact_number,
      :email_address
    )
  end
end
