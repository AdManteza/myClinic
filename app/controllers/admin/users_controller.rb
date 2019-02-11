class Admin::UsersController < Admin::AdminController
  before_action :user, only: [:show, :edit, :update, :destroy]
  before_action :users, only: [:index]

  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html do; end
      format.json { render json: @users }
    end
  end

  def create
    @user = current_site.users.build(user_params)

    respond_to do |format|
      if @user.save
        format.html do
          redirect_to admin_user_path(@user), notice: 'User was successfully created.'
        end

        format.json do
          render json: @user
        end
      else
        format.html do
          flash[:error] = @user.errors.full_messages
          render :new
        end

        format.json do
          render json: @user.errors, status: :unprocessable_entity
        end
      end
    end
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html do
          redirect_to admin_user_path(@user), notice: 'User was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.html do
        redirect_to admin_users_path, notice: "#{@user.full_name} was successfully deleted."
      end

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

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.fetch(:user).permit(
      :username,
      :firstname,
      :lastname,
      :password
    )
  end
end
