class UsersController < ApplicationController
  def edit; end

  def update
    if current_user.update info_params
      flash[:success] = "Cập nhật thành công"
      redirect_to edit_user_path(current_user)
    else
      render :edit
    end
  end

  def password; end

  def update_password
    error = "Password hiện tại không đúng" unless current_user.valid_password?(params[:current_password])
    if error.blank? && current_user.update(password_params)
      bypass_sign_in(current_user)
      flash[:success] = "Cập nhật mật khẩu thành công"
      redirect_to password_user_path(current_user)
    else
      flash[:danger] = error if error.present?
      render :password
    end
  end

  private

  def info_params
    params.require(:user).permit :name, :image
  end

  def password_params
    params.require(:user).permit :password, :password_confirmation
  end
end
