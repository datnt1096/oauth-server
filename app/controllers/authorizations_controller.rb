class AuthorizationsController < ApplicationController
  before_action :check_authorization, only: :authorize
  before_action :find_oauth_app, only: %i(new create)
  skip_before_action :authenticate_user!, only: :token
  skip_before_action :verify_authenticity_token, only: %i(token delete)

  def index
    @authorizations = current_user.authorizations.includes(:oauth_app).order(created_at: :desc)
  end

  def new
    @authorization = Authorization.new
    render layout: false
  end

  def create
    if params[:commit].eql?("Accept")
      current_user.authorizations.create oauth_app: @app
      url = session.delete :user_redirect_back
      redirect_to url
    else
      session.delete :user_redirect_back
      redirect_to @app.callback_url
    end
  end

  def destroy
    @authorization = current_user.authorizations.find_by id: params[:id]
    if @authorization.destroy
      flash[:success] = "Xóa ủy quyền thành công"
    else
      flash[:danger] = "Xóa ủy quyền thất bại"
    end
    redirect_to authorizations_path
  end

  def authorize
    code = SecureRandom.hex(20)
    @authorization.update authorize_code: code
    redirect_to "#{params[:redirect_uri]}?code=#{code}&state=#{params[:state]}"
  end

  def token
    return render_response({}, 401) unless (params[:client_id].present? && params[:client_secret].present? &&
      params[:grant_type].present?)

    @app = OauthApp.find_by id: params[:client_id]
    if @app.present? && @app.secret_key.eql?(params[:client_secret])
      return authorization_code_grant if params[:grant_type].eql?("authorization_code")
      return client_credentials_grant if params[:grant_type].eql?("client_credentials")
    end

    render_response({}, 401)
  end

  private

  def check_authorization
    return redirect_to root_path unless (params[:client_id].present? && params[:redirect_uri].present? &&
      params[:response_type]&.eql?("code") && params[:state].present?)

    find_oauth_app
    @authorization = current_user.authorizations.find_by oauth_app_id: @app.id
    if @authorization.blank?
      session[:user_redirect_back] = request.url
      redirect_to new_authorization_path(client_id: @app.id)
    end
  end

  def find_oauth_app
    @app = OauthApp.find_by id: params[:client_id]
    return redirect_to root_path unless @app.present?
  end

  def authorization_code_grant
    return render_response({}, 401) if params[:code].blank?

    authorization = @app.authorizations.find_by authorize_code: params[:code]
    if authorization.present?
      token = SecureRandom.hex(30)
      authorization.update token: token, token_created_at: Time.now, authorize_code: nil
      render_response({access_token: token, expires_in: 7.days.from_now.to_s}, 200)
    else
    end
  end

  def client_credentials_grant
  end
end
