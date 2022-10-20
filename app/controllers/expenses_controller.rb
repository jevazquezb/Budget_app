class ExpensesController < ApplicationController
  before_action :set_group
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @expenses = @group.expenses.order(created_at: :desc)
  end

  def new
    @expense = Expense.new
  end

  def create
    @expense = Expense.new(expense_params)
    @expense.user_id = current_user.id
    @group.expenses << @expense

    respond_to do |format|
      if @expense.save
        format.html { redirect_to group_expenses_path(@group.id), notice: 'Transaction was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @expense = Expense.find(params[:id])
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy

    respond_to do |format|
      format.html { redirect_to group_expenses_path(@group.id), notice: 'Transaction was successfully destroyed.' }
    end
  end

  def set_group
    @group = Group.find(params[:group_id])
  end

  def expense_params
    params.require(:expense).permit(:name, :amount).merge(user_id: current_user.id)
  end

  private :expense_params, :set_group
end
