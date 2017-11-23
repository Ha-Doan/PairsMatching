require 'rails_helper'

feature "find matches", js: true do
  let!(:user) { create :user, email: "current@user.com", password: "123456", role: "student" }
  let!(:another_user) { create :user, email: "another@user.com", role: "student" }

  before { login_as user }

  scenario 'login as student' do

    visit root_path
    sleep(0)
    expect(page).to have_content "You are logged in as a student."

  end

  scenario 'see your match' do

    visit root_path

    expect(page). to have_content "You are matched with another@user.com"
  end

end
