require 'rails_helper'

RSpec.describe 'Expenses', type: :request do
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
    GroupExpense.create(
      group_id: @group.id,
      expense_id: @expense.id
    )
  end

  context '/categories/:group_id/transactions route (GET #index)' do
    before { get group_expenses_path(@group.id) }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('index')
    end

    it 'should render the correct text' do
      expect(response.body).to include('Mazatlán')
    end
  end

  context '/categories/:group_id/transactions/:id route (GET #show)' do
    before { get group_expense_path(@group.id, @expense.id) }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it 'renders the index template' do
      expect(response).to render_template('show')
    end

    it 'should render the correct text' do
      expect(response.body).to include('$ 4568')
      expect(response.body).to include('Delete transaction')
    end
  end
end