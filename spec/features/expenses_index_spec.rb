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

    (1..5).each do |id|
      expense = Expense.create(
        user_id: @user.id,
        name: "Transaction #{id}",
        amount: 4568
      )

      @group.expenses << expense
    end

    visit group_expenses_path(@group.id)
  end

  it 'should render the correct text' do
    expect(page).to have_content('Transaction 5')
    expect(page).to have_content('Transaction 4')
    expect(page).to have_content('Transaction 3')
    expect(page).to have_content('Transaction 2')
    expect(page).to have_content('Transaction 1')
  end

  it 'should lead to the correct page when a transaction is clicked' do
    transaction_two = Expense.find_by(name: 'Transaction 2')
    click_link 'Transaction 2'
    expect(current_path).to eq(group_expense_path(@group.id, transaction_two.id))
  end

  it 'should have a link to add a new transaction' do
    expect(page).to have_link('Add new transaction')
  end

  it 'should lead to /categories/:group_id/transactions/new page when "Add new transaction" link is clicked' do
    click_link('Add new transaction')
    expect(current_path).to eq(new_group_expense_path(@group.id))
  end
end
