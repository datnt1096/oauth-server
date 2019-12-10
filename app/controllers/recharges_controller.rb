class RechargesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update, :destroy]
  before_action :valid_admin, only: [:pending, :done]
  before_action :find_recharge, :valid_admin, only: [:update, :destroy]

  def index
    @recharges = current_user.recharges.order(created_at: :desc)
  end

  def new
    @recharge = Recharge.new
  end

  def create
    @recharge = current_user.recharges.new recharge_params
    if @recharge.save
      flash[:success] = "Tạo thành công"
      redirect_to recharges_path
    else
      render :new
    end
  end

  def update
    ActiveRecord::Base.transaction do
      current_amount = @recharge.user.wallet
      @recharge.user.update wallet: (current_amount + @recharge.amount)
      @recharge.done!
    end
    redirect_to pending_recharges_path
  end

  def destroy
    @recharge.cancel!
    redirect_to pending_recharges_path
  end

  def pending
    @recharges = Recharge.where(status: :pending).includes(:user).order(:created_at)
  end

  def done
    @recharges = Recharge.where.not(status: :pending).includes(:user).order(created_at: :desc)
  end

  private

  def find_recharge
    @recharge = Recharge.find_by id: params[:id]
  end

  def recharge_params
    params.require(:recharge).permit :amount
  end

  def valid_admin
    redirect_to root_path unless current_user.admin?
  end
end
