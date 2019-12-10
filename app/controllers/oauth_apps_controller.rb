class OauthAppsController < ApplicationController
  before_action :load_app, only: %i(show edit update destroy secret_keys)
  def index
    @apps = current_user.oauth_apps.order_asc
  end

  def new
    @app = OauthApp.new
  end

  def create
    @app = current_user.oauth_apps.new update_params
    @app.secret_key = SecureRandom.base64 50

    if @app.save
      flash[:success] = "Tạo mới thành công"
      redirect_to oauth_apps_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @app.update update_params
      flash[:success] = "Cập nhật thành công"
      redirect_to edit_oauth_app_path(@app)
    else
      render :edit
    end
  end

  def destroy
    if @app.destroy
      flash[:error] = "Xóa thành công"
    else
      flash[:error] = "Xóa thất bại"
    end

    redirect_to oauth_apps_path
  end

  def secret_keys
    @app.update secret_key: SecureRandom.base64(50)
    flash[:success] = "Đổi khóa bí mật thành công"
    redirect_to edit_oauth_app_path(@app)
  end

  private

  def load_app
    @app = OauthApp.find_by id: params[:id]
  end

  def update_params
    params.require(:oauth_app).permit :name, :home_page, :description, :callback_url
  end
end
