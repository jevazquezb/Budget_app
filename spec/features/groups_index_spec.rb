require 'rails_helper'

RSpec.describe 'Groups index page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Jesús',
      email: 'jesus@email.com',
      password: '112233',
      password_confirmation: '112233'
    )

    sign_in @user

    (1..5).each do |id|
      Group.create(
        user_id: @user.id,
        name: "Category #{id}",
        icon: '🏖️'
      )
    end

    visit groups_path
  end

  it 'should render the correct text' do
    expect(page).to have_content('Category 5')
    expect(page).to have_content('Category 4')
    expect(page).to have_content('Category 3')
    expect(page).to have_content('Category 2')
    expect(page).to have_content('Category 1')
  end

  it 'should lead to the correct page when a category is clicked' do
    group_three = Group.find_by(name: 'Category 3')
    click_link 'Category 3'
    expect(current_path).to eq(group_expenses_path(group_three.id))
  end

  it 'should have a link to add a new category' do
    expect(page).to have_link('Add new category')
  end

  it 'should lead to /categories/new page when "Add new category" link is clicked' do
    click_link('Add new category')
    expect(current_path).to eq(new_group_path)
  end
end
