require 'rails_helper'

RSpec.describe Expense, type: :model do
  before :each do
    @user = User.create(
      name: 'Jesús',
      email: 'jesus@email.com',
      password: '112233',
      password_confirmation: '112233'
    )
    @expense = Expense.create(
      user_id: @user.id,
      name: 'Mazatlán',
      amount: 4568
    )
  end

  context 'Expense Model Properties' do
    it 'should have a user' do
      @expense.user_id = nil
      expect(@expense).to_not be_valid
    end

    it 'name should be present' do
      @expense.name = nil
      expect(@expense).to_not be_valid
    end

    it 'amount should be present' do
      @expense.amount = nil
      expect(@expense).to_not be_valid
    end

    it 'amount should be greater than 0' do
      @expense.amount = 0
      expect(@expense).to_not be_valid
    end
  end
end
