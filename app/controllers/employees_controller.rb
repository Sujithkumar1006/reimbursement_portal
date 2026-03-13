class EmployeesController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_employee, only: %i[edit update destroy]
  before_action :set_departments, only: %i[new create edit update]

  def index
    @employees = Employee.includes(:user, :department).order(created_at: :desc)
  end

  def new
    @employee = Employee.new
    @user = User.new
  end

  def create
    @user = build_employee_user
    @employee = Employee.new(employee_params)
    @employee.user = @user

    if save_employee_with_user
      redirect_to employees_path, notice: "Employee created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @user = @employee.user
  end

  def update
    @user = @employee.user

    ActiveRecord::Base.transaction do
      @user.update!(user_params)
      @employee.update!(employee_params)
    end

    redirect_to employees_path, notice: "Employee updated successfully."
  rescue ActiveRecord::RecordInvalid
    render :edit, status: :unprocessable_entity
  end

  def destroy
    if @employee.user == current_user
      redirect_to employees_path, alert: "You cannot delete your own account."
    else
      @employee.user.destroy
      redirect_to employees_path, notice: "Employee deleted successfully."
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def set_departments
    @departments = Department.order(:name)
  end

  def build_employee_user
    user = User.new(user_params)
    user.role = :employee
    user
  end

  def save_employee_with_user
    return false unless @user.valid? && @employee.valid?

    ActiveRecord::Base.transaction do
      @user.save!
      @employee.save!
    end

    true
  rescue ActiveRecord::RecordInvalid
    false
  end

  def employee_params
    params.require(:employee).permit(:designation, :department_id)
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
