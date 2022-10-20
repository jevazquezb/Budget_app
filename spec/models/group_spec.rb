require 'rails_helper'

RSpec.describe Group, type: :model do
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
  end

  context 'Group Model Properties' do
    it 'should have a user' do
      @group.user_id = nil
      expect(@group).to_not be_valid
    end

    it 'name should be present' do
      @group.name = nil
      expect(@group).to_not be_valid
    end

    it 'icon should be present' do
      @group.icon = nil
      expect(@group).to_not be_valid
    end

    it 'name should be unique' do
      @duplicate_group = Group.create(
        user_id: @user.id,
        name: 'Holidays',
        icon: '🏖️'
      )
      expect(@duplicate_group).to_not be_valid
    end
  end
end
