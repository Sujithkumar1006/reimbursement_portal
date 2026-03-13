class BillsController < ApplicationController
  before_action :require_login
  before_action :set_bill, only: :update
  before_action :require_admin, only: :update

  def index
    @bills = current_user.admin? ? all_bills : current_user.bills.order(created_at: :desc)
  end

  def new
    @bill = current_user.bills.build(status: :pending)
  end

  def create
    @bill = current_user.bills.build(bill_params.merge(status: :pending))

    if @bill.save
      redirect_to bills_path, notice: "Bill submitted successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if valid_status?
      @bill.update(status: params[:status])
      redirect_to bills_path, notice: "Bill status updated successfully."
    else
      redirect_to bills_path, alert: "Invalid status."
    end
  end

  private

  def set_bill
    @bill = Bill.find(params[:id])
  end

  def all_bills
    Bill.includes(user: { employee: :department }).order(created_at: :desc)
  end

  def valid_status?
    params[:status].in?(%w[approved rejected])
  end

  def bill_params
    params.require(:bill).permit(:bill_type, :amount)
  end
end
