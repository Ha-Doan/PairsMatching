require 'rails_helper'

feature 'manage roles', js: true do
 let!(:user) { create :user, email: "current@user.com", password: "123456", role: "admin" }
 let!(:another_user) { create :user, email: "another@user.com", role: "student" }

   before { login_as user }
   scenario 'login as admin' do

    visit root_path

    expect(page).to have_content "You are logged in as an admin."
    expect(page).to have_content "another@user.com"
   end

   scenario 'change another_user to admin' do

     visit root_path
     sleep(1)
     find('tr', text: "another").click_link("make admin or student")

     sleep(1)
     page.driver.browser.switch_to.alert.accept
     sleep(3)
     expect(page).to have_content "User updated"
     expect(page).to have_content "admin"
   end
end
