When /^go the new burndown page$/ do
  visit "/admin/burndowns/new"
end

When /^I fill out the burndown form$/ do
  within('#new_burndown') do
    fill_in "Name", with: "My Burndown"
    fill_in "Pivotal Tracker API Token", with: "pivotal-token"
    fill_in "Pivotal Tracker Project ID", with: "123123"

    click_button "Create Burndown"
  end
end

Then /^I should have a new burndown$/ do
  burndown = Burndown.last
  visit "/admin/burndowns/#{burndown.id}"

  expect(page).to have_content("My Burndown")
  expect(page).to have_content("pivotal-token")
  expect(page).to have_content("123123")
end
