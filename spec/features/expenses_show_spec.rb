require 'rails_helper'

RSpec.describe 'Expenses index page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Jesús',
      email: 'jesus@email.com',
      password: '112233',
      password_confirmation: '112233'
    )

    sign_in @user

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

    @group.expenses << @expense

    visit group_expense_path(@group.id, @expense.id)
  end

  it 'should have a button to delete a transaction' do
    expect(page).to have_button('Delete transaction')
  end

  it 'should lead to /categories/:group_id/transactions page when "Delete transaction" button is clicked' do
    click_button('Delete transaction')
    expect(current_path).to eq(group_expenses_path(@group.id))
  end

  it 'should have no expenses after removing transaction' do
    click_button('Delete transaction')
    expect(@group.expenses.length).to eq(0)
  end
end