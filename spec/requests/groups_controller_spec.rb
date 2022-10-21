require 'rails_helper'

RSpec.describe 'Groups', type: :request do
  before :each do
    @user = User.create(
      name: 'Jesús',
      email: 'jesus@email.com',
      password: '112233',
      password_confirmation: '112233'
    )

    sign_in @user

    Group.create(
      user_id: @user.id,
      name: 'Holidays',
      icon: '🏖️'
    )
  end

  context '/categories route (GET #index)' do
    before { get groups_path }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render index.html.erb file from views/groups (render 'index' template)" do
      expect(response).to render_template('index')
    end

    it 'should render the correct text' do
      expect(response.body).to include('Holidays')
    end
  end
end
