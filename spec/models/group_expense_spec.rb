require 'rails_helper'

RSpec.describe GroupExpense, type: :model do
  before :each do
    @user = User.create(
      name: 'Jesús',
      email: 'jesus@email.com',
      password: '112233',
      password_confirmation: '112233'
    )
    @group = Group.create(
      user_id: @user.id,
      name: 'Holidays',
      icon: '🏖️'
    )
    @expense = Expense.create(
      user_id: @user.id,
      name: 'Mazatlán',
      amount: 4568
    )
    @group_expense = GroupExpense.create(
      group_id: @group.id,
      expense_id: @expense.id
    )
  end

  context 'GroupExpense Model Properties' do
    it 'should have a group' do
      @group_expense.group_id = nil
      expect(@group_expense).to_not be_valid
    end

    it 'should have an expense' do
      @group_expense.expense_id = nil
      expect(@group_expense).to_not be_valid
    end
  end
end