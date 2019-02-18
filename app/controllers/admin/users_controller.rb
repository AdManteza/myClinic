class Admin::UsersController < Admin::AdminController
  before_action :user, only: [:show, :edit, :update, :destroy]
  before_action :users, only: [:index]

  def index
    respond_to do |format|
      format.html do; end
      format.json { render json: @users }
    end
  end

  def create
    @user = current_site.users.build(user_params)
    @user.password = PasswordStrategy.random if user_params[:password].blank?

    respond_to do |format|
      if @user.save
        format.html do; end
        format.json { render json: @user }
      else
        format.html do; end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do; end
        format.json { render json: @user }
      else
        format.html do; end
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy

    respond_to do |format|
      format.html do; end
      format.json { head :no_content }
    end
  end

private

  def user
    @user ||= current_site.users.where(id: params[:id]).first
  end

  def users
    @users ||= current_site.users
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
