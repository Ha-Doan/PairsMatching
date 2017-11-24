require 'rails_helper'

feature "sign-up and become student", js: true do
  let(:user) { build :user }
  let!(:another_user) { create :user, email: "another@user.com", role: "student" }

  scenario 'sign-up as new user' do

    visit root_path

    expect(page).to have_content "Sign up"
    sleep(0)
    click_link "Sign up"
    sleep(0)
    fill_in 'Email',                  with: user.email
    fill_in 'Password',               with: user.password
    fill_in 'Password confirmation',  with: user.password
    click_button 'Sign up'
    sleep(0)
    expect(page).to have_content "You are logged in as a student."
    expect(page).to have_content "You are matched with another@user.com"
  end
end
