require 'spec_helper'

describe 'ActiveAdmin sign in' do

  subject(:admin_user) { Fabricate(:admin_user) }

  it "signs me in" do
    visit '/admin'

    within('#login') do
      fill_in "Email", with: admin_user.email
      fill_in "Password", with: "password"
    end
    click_button "Login"

    page.should have_content "Signed in successfully"
  end
end
