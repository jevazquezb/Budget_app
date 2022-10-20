require 'rails_helper'

RSpec.describe 'Pages', type: :request do
  context 'root route (GET #splash_screen)' do
    before { get root_path }

    it 'should be a success when called' do
      expect(response).to have_http_status(:ok)
    end

    it "should render splash_screen.html.erb file from views/pages (render 'splash_screen' template)" do
      expect(response).to render_template('splash_screen')
    end

    it 'should render the correct text' do
      expect(response.body).to include('Finapp')
      expect(response.body).to include('LOG IN')
      expect(response.body).to include('SIGN UP')
    end
  end
end
